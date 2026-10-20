# PROTOTYPE (throwaway): Lobby and table screens
# https://github.com/alexandreruban/belote/issues/13
#
# What one viewer (alex) may see of the Lobby or of their Game, for a handful of hand-written
# scenarios. Positions are relative to the viewer, in clockwise (play) order: :me, :left, :partner, :right.
# Teams: :us is me + partner, :them is left + right. No persistence, no rules engine.
class Prototype::Screens::Scene
  Card = Prototype::Screens::Card

  SCENARIOS = {
    "lobby" => "Lobby: two waiting",
    "lobby-joined" => "Lobby: you're waiting (3/4)",
    "trump-1" => "1st Trump round: your turn",
    "trump-1-others" => "1st Trump round: noor's turn",
    "trump-2" => "2nd Trump round: your turn",
    "play-follow" => "Trick 4: your turn, follow ♥",
    "trick-won" => "Trick 4 won by sam, sam leads",
    "play-trump" => "Trick 5: your turn, must trump",
    "belote" => "Trick 5: you called Belote",
    "deal-scored" => "Deal 6 scored, Deal 7 begins"
  }

  # Where each stubbed action leads. Anything else stays on the same scenario.
  AFTER = {
    "lobby" => { join: "lobby-joined" },
    "lobby-joined" => { leave: "lobby" },
    "trump-1" => { take: "play-follow", pass: "trump-1-others" },
    "trump-2" => { take: "play-follow" },
    "play-follow" => { play: "trick-won" },
    "play-trump" => { play: "belote" },
    "deal-scored" => { take: "play-follow" }
  }

  POSITIONS = %i[ me left partner right ]
  USERNAMES = { me: "alex", left: "noor", partner: "camille", right: "sam" }
  TARGET = 1000

  # Deals 1–5 of the Game; Deal 6 is the one being played.
  HISTORY = [
    { number: 1, taker: :left, trump: :hearts, result: :made, us: 58, them: 104 },
    { number: 2, taker: :me, trump: :clubs, result: :dedans, us: 0, them: 162 },
    { number: 3, taker: :partner, trump: :diamonds, result: :made, us: 128, them: 54, belote: :us },
    { number: 4, taker: nil, trump: nil, result: :dropped, us: 0, them: 0 },
    { number: 5, taker: :right, trump: :spades, result: :dedans, us: 162, them: 0 }
  ]
  DEAL_6 = { number: 6, taker: :me, trump: :spades, result: :made, us: 112, them: 70, belote: :us }

  TRICK_3 = { cards: [ [ :partner, Card["Q♣"] ], [ :right, Card["7♣"] ], [ :me, Card["8♣"] ], [ :left, Card["A♣"] ] ], winner: :left }
  TRICK_4 = { cards: [ [ :left, Card["K♥"] ], [ :partner, Card["7♥"] ], [ :right, Card["A♥"] ], [ :me, Card["10♥"] ] ], winner: :right }

  attr_reader :key, :screen, :waiting,
    :deal_number, :phase, :dealer, :to_act, :turned_card, :spoken, :trump, :taker,
    :trick_number, :trick, :winning, :last_trick, :hand, :legal, :must, :led_suit,
    :hand_counts, :tricks_won, :announcement, :scores, :history, :previous_deal

  def self.build(key) = new(key:, **send(key.underscore))

  def initialize(key:, screen: :table, waiting: [], deal_number: 6, phase: nil, dealer: :partner, to_act: nil,
                 turned_card: nil, spoken: {}, trump: nil, taker: nil, trick_number: nil, trick: [], winning: nil,
                 last_trick: nil, hand: [], legal: [], must: nil, led_suit: nil, hand_counts: {}, tricks_won: nil,
                 announcement: nil, scores: { us: 348, them: 320 }, history: HISTORY, previous_deal: nil)
    @key, @screen, @waiting = key, screen, waiting
    @deal_number, @phase, @dealer, @to_act, @turned_card, @spoken, @trump, @taker =
      deal_number, phase, dealer, to_act, turned_card, spoken, trump, taker
    @trick_number, @trick, @winning, @last_trick, @hand, @legal, @must, @led_suit =
      trick_number, trick, winning, last_trick, hand, legal, must, led_suit
    @hand_counts, @tricks_won, @announcement, @scores, @history, @previous_deal =
      hand_counts, tricks_won, announcement, scores, history, previous_deal
  end

  # Lobby

  def lobby? = screen == :lobby
  def joined? = waiting.include?(USERNAMES[:me])
  def missing = 4 - waiting.size

  # Table

  def username(position) = USERNAMES.fetch(position)
  def team(position) = position.in?(%i[ me partner ]) ? :us : :them
  def my_turn? = to_act == :me

  def choosing_trump? = phase.in?(%i[ trump_round_1 trump_round_2 ])
  def playing? = phase == :playing
  def trump_round = { trump_round_1: 1, trump_round_2: 2 }[phase]

  # Round 1 offers the Turned card's suit; round 2 any of the other three.
  def trump_choices
    trump_round == 1 ? [ turned_card.suit ] : Card::SYMBOLS.keys - [ turned_card.suit ]
  end

  def playable?(card) = playing? && my_turn? && legal.include?(card)

  # The card of the current Trick played by that position, if any.
  def played_by(position) = trick.to_h[position]

  # Strongest first within each suit, Trump first, then alternating colours.
  def hand_by_suit
    suits = ([ trump ] + %i[ spades hearts clubs diamonds ]).compact.uniq
    hand.group_by(&:suit).sort_by { |suit, _| suits.index(suit) }.to_h
      .transform_values { |cards| cards.sort_by { -it.strength(trump) } }
  end

  def to_h
    instance_variables.to_h { [ it.to_s.delete("@"), instance_variable_get(it) ] }
      .except("history").transform_values { it.is_a?(Card) ? it.to_s : it }
  end

  # The scenarios, one class method each, named after their key.

  def self.lobby
    { screen: :lobby, waiting: %w[ noor sam ] }
  end

  def self.lobby_joined
    { screen: :lobby, waiting: %w[ noor sam alex ] }
  end

  def self.trump_1
    { phase: :trump_round_1, to_act: :me, turned_card: Card["9♠"], spoken: { right: :pass },
      hand: %w[ K♠ Q♠ 10♥ 8♥ 9♣ ].map { Card[it] }, hand_counts: { me: 5, left: 5, partner: 5, right: 5 } }
  end

  def self.trump_1_others
    trump_1.merge(to_act: :left, spoken: { right: :pass, me: :pass })
  end

  def self.trump_2
    trump_1.merge(phase: :trump_round_2, spoken: { right: :pass })
  end

  def self.play_follow
    { phase: :playing, trump: :spades, taker: :me, trick_number: 4, to_act: :me,
      trick: [ [ :left, Card["K♥"] ], [ :partner, Card["7♥"] ], [ :right, Card["A♥"] ] ], winning: :right,
      hand: %w[ K♠ Q♠ 10♥ 8♥ 9♣ ].map { Card[it] }, legal: [ Card["10♥"], Card["8♥"] ],
      must: :follow_suit, led_suit: :hearts, last_trick: TRICK_3,
      hand_counts: { me: 5, left: 4, partner: 4, right: 4 }, tricks_won: { us: 2, them: 1 } }
  end

  def self.trick_won
    { phase: :playing, trump: :spades, taker: :me, trick_number: 5, to_act: :right,
      hand: %w[ K♠ Q♠ 8♥ 9♣ ].map { Card[it] }, last_trick: TRICK_4,
      hand_counts: { me: 4, left: 4, partner: 4, right: 4 }, tricks_won: { us: 2, them: 2 } }
  end

  def self.play_trump
    trick_won.merge(to_act: :me, trick: [ [ :right, Card["Q♦"] ] ], winning: :right,
      legal: [ Card["K♠"], Card["Q♠"] ], must: :trump, led_suit: :diamonds,
      hand_counts: { me: 4, left: 4, partner: 4, right: 3 })
  end

  def self.belote
    trick_won.merge(to_act: :left, trick: [ [ :right, Card["Q♦"] ], [ :me, Card["K♠"] ] ], winning: :me,
      hand: %w[ Q♠ 8♥ 9♣ ].map { Card[it] }, announcement: { position: :me, call: :belote, card: Card["K♠"] },
      hand_counts: { me: 3, left: 4, partner: 4, right: 3 })
  end

  # Deal 6 has just been scored; Deal 7 is dealt at once, and sam deals.
  def self.deal_scored
    { deal_number: 7, phase: :trump_round_1, dealer: :right, to_act: :me, turned_card: Card["10♣"],
      hand: %w[ J♣ A♦ 9♥ Q♥ 7♠ ].map { Card[it] }, hand_counts: { me: 5, left: 5, partner: 5, right: 5 },
      scores: { us: 460, them: 390 }, history: HISTORY + [ DEAL_6 ], previous_deal: DEAL_6 }
  end
end
