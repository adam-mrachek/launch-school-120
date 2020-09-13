require 'pry'

class Hand
  attr_accessor :cards

  VALUES = {
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9,
    '10' => 10,
    'Jack' => 10,
    'Queen' => 10,
    'King' => 10,
    'Ace' => 11
  }

  def initialize
    @cards = []
  end

  def busted?

  end

  def total
    binding.pry
    cards.sum{ |card| VALUES[card[0]] }
  end
end

class Participant
  attr_reader :name, :type

  def initialize(type = :dealer)
    @type = type
    @name = set_name
    @hand = Hand.new
  end

  def set_name
    @name = if type == :dealer
              'Dealer'
            else
              choose_player_name
            end
  end

  def hand
    @hand.cards
  end

  def hand=(card)
    @hand.cards << card
  end

  def choose_player_name
    name = nil
    loop do
      puts "Please enter your name (letters and numbers only):"
      name = gets.chomp 
      break unless name.strip.empty?
      puts "Sorry, that's not a valid name."
    end
    name
  end

  def dealer?
    @type == :dealer
  end

  def hit

  end

  def stay
  end
end

class Deck
  attr_reader :cards

  SUITS = %w(Diamonds Hearts Clubs Spades)
  VALUES = %w(2 3 4 5 6 7 8 9 Jack Queen King Ace)
  
  def initialize
    @cards = shuffle
  end

  def shuffle
    @cards = VALUES.product(SUITS).shuffle
  end
end

class Game
  attr_accessor :deck, :player, :dealer

  def initialize
    @deck = Deck.new.cards
    @player = Participant.new(type: :player)
    @dealer = Participant.new
  end

  def start
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn
    show_result
  end

  def deal_cards
    2.times do 
      player.hand << deck.pop
      dealer.hand << deck.pop
    end
  end

  def show_initial_cards
    puts "Dealer shows: #{dealer.hand[0][0]} of #{dealer.hand[0][1]}"
    puts "Dealer total: #{Hand::VALUES[dealer.hand[0][0]]}"
    puts ""
    puts "#{player.name} has:"
    player.hand.each do |card|
      puts "#{card[0]} of #{card[1]}"
    end
    puts "Total: #{player.hand.total}"
  end
end

Game.new.start