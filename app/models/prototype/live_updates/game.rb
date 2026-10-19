# PROTOTYPE (throwaway, branch prototype/live-updates): just enough of a Game to push
# live updates around. No trump, no scoring: four seats, eight Tricks, follow suit.
#
# Game state is a plain Hash so it survives code reloading in development.
module Prototype::LiveUpdates::Game
  class IllegalMove < StandardError; end

  SEATS = %w[north east south west] # clockwise
  RANKS = %w[7 8 9 10 J Q K A]
  SUITS = %w[S H D C]
  SYMBOLS = { "S" => "♠", "H" => "♥", "D" => "♦", "C" => "♣" }

  module_function

  def new_state
    deal("variant" => "A", "bug" => false, "refresh_debounce" => 150, "version" => 0)
  end

  def deal(state)
    deck = RANKS.product(SUITS).map(&:join).shuffle
    touch state.merge(
      "hands" => SEATS.each_with_index.to_h { |seat, i| [ seat, sort(deck[i * 8, 8]) ] },
      "trick" => [],
      "turn" => "north",
      "tricks_won" => SEATS.index_with(0),
      "last_actor" => "north"
    )
  end

  def play(state, seat, card)
    raise IllegalMove, "not #{seat}'s turn" unless state["turn"] == seat
    raise IllegalMove, "#{card} is not playable" unless playable(state, seat).include?(card)

    trick = current_trick(state) + [ { "seat" => seat, "card" => card } ]
    hands = state["hands"].merge(seat => state["hands"][seat] - [ card ])
    tricks_won = state["tricks_won"]
    turn = next_seat(seat)

    if trick.size == 4
      winner = trick_winner(trick)
      tricks_won = tricks_won.merge(winner => tricks_won[winner] + 1)
      turn = hands[winner].any? ? winner : nil
    end

    touch state.merge("trick" => trick, "hands" => hands, "tricks_won" => tricks_won, "turn" => turn, "last_actor" => seat)
  end

  def playable(state, seat)
    return [] unless state["turn"] == seat

    hand = state["hands"][seat]
    trick = current_trick(state)
    return hand if trick.empty?

    led = suit(trick.first["card"])
    following = hand.select { suit(it) == led }
    following.any? ? following : hand
  end

  # The only thing that may ever reach one Player: public state plus their own hand.
  def view_for(state, seat)
    {
      "seat" => seat,
      "version" => state["version"],
      "stamp" => state["stamp"],
      "turn" => state["turn"],
      "trick" => state["trick"],
      "trick_winner" => (trick_winner(state["trick"]) if state["trick"].size == 4),
      "tricks_won" => state["tricks_won"],
      "card_counts" => SEATS.index_with { state["hands"][it].size },
      "hand" => state["hands"][seat],
      "playable" => playable(state, seat)
    }
  end

  # Partner opposite, left-hand opponent next clockwise.
  def around(seat)
    i = SEATS.index(seat)
    { "left" => SEATS[(i + 1) % 4], "partner" => SEATS[(i + 2) % 4], "right" => SEATS[(i + 3) % 4] }
  end

  def label(card)
    "#{card[0..-2]}#{SYMBOLS[suit(card)]}"
  end

  def suit(card) = card[-1]
  def rank(card) = card[0..-2]
  def red?(card) = %w[H D].include?(suit(card))

  def current_trick(state)
    state["trick"].size == 4 ? [] : state["trick"]
  end

  def trick_winner(trick)
    led = suit(trick.first["card"])
    trick.select { suit(it["card"]) == led }.max_by { RANKS.index(rank(it["card"])) }["seat"]
  end

  def next_seat(seat)
    SEATS[(SEATS.index(seat) + 1) % 4]
  end

  def sort(cards)
    cards.sort_by { [ SUITS.index(suit(it)), RANKS.index(rank(it)) ] }
  end

  def touch(state)
    state.merge("version" => state["version"] + 1, "stamp" => (Time.now.to_f * 1000).round)
  end
end
