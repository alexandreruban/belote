# PROTOTYPE (throwaway): a card, written Card["K♠"] or Card["10♥"].
class Prototype::Screens::Card < Data.define(:rank, :suit)
  SYMBOLS = { spades: "♠", hearts: "♥", clubs: "♣", diamonds: "♦" }
  PLAIN_ORDER = %w[ 7 8 9 J Q K 10 A ] # weakest first
  TRUMP_ORDER = %w[ 7 8 Q K 10 A 9 J ]

  def self.[](text) = new(rank: text[0..-2], suit: SYMBOLS.key(text[-1]))

  def symbol = SYMBOLS.fetch(suit)
  def red? = suit.in?(%i[ hearts diamonds ])
  def to_s = "#{rank}#{symbol}"

  def strength(trump)
    (suit == trump ? TRUMP_ORDER : PLAIN_ORDER).index(rank)
  end
end
