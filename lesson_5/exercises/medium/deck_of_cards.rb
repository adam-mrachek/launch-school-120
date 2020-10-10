class Card
  include Comparable
  attr_reader :rank, :suit

  VALUES = { 'Jack' => 10, 'Queen' => 11, 'King' => 12, 'Ace' => 13}

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value 
    VALUES.fetch(rank, rank)
  end

  def to_s
    "#{rank} of #{suit} "
  end

  def <=>(other_card)
    value <=> other_card.value
  end
end

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    @cards = []
    shuffle_deck
  end

  def shuffle_deck
    SUITS.each do |suit|
      RANKS.each do |rank|
        @cards << Card.new(rank, suit)
      end
    end
    @cards.shuffle
  end

  def draw
    shuffle_deck if @cards.empty?
    @cards.pop
  end
end

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
puts drawn.count { |card| card.rank == 5 } == 4
puts drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
puts drawn != drawn2 # Almost always.