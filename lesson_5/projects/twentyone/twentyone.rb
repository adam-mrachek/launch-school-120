require 'pry'

class Card
  attr_reader :suit, :rank

  SUITS = %w(Diamonds Hearts Clubs Spades)
  RANKS = %w(2 3 4 5 6 7 8 9 Jack Queen King Ace)

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

module Hand
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

  def busted?
    self.total > 21
  end

  def total
    total = hand.sum{ |card| VALUES[card.rank] }

    hand.select{ |card| card.rank == 'Ace' }.count.times do
      break if total <= 21
      total -= 10
    end
    total
  end
end

class Player
  include Hand
  attr_reader :name, :type
  attr_accessor :hand

  def initialize
    @name = nil
    @hand = []
  end

  def choose_name
    name = nil
    loop do
      puts "Please enter your name (letters and numbers only):"
      name = gets.chomp 
      break unless name.strip.empty?
      puts "Sorry, that's not a valid name."
    end
    @name = name
  end

  def show_cards
    puts ""
    puts "#{name} has:"
    hand.each do |card|
      puts "> #{card}"
    end
    puts "Total: #{total}"
    puts ""
  end
end

class Dealer < Player
  def initialize
    super
    @name = 'Dealer'
  end
end

class Deck
  attr_reader :cards
  
  def initialize
    @cards = []
    setup
    shuffle!
  end

  def setup
    Card::RANKS.each do |rank|
      Card::SUITS.each do |suit|
        @cards << Card.new(suit, rank)
      end
    end
  end

  def shuffle!
    @cards.shuffle!
  end

  def deal_card
    cards.pop
  end
end

class Game
  attr_accessor :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    game_setup
    loop do
      deal_cards
      show_flop
      play_hand
      show_result
      play_again? ? reset : break
    end
  end

  def game_setup
    player.choose_name
  end

  def reset
    self.deck = Deck.new
    player.hand = []
    dealer.hand = []
  end

  def deal_cards
    2.times do 
      player.hand << deck.deal_card
      dealer.hand << deck.deal_card
    end
  end

  def show_flop
    puts "Dealer shows:"
    puts "> #{dealer.hand[0]}"
    puts "Total: #{Hand::VALUES[dealer.hand[0].rank]}"
    puts ""
  end

  def hit?
    choice = nil
    loop do
      puts "Hit or stay? (enter 'h' or 's')"
      choice = gets.chomp.downcase
      break if %w(h s).include?(choice)
      puts "Not a valid choice."
    end
    choice == 'h'
  end

  def player_turn
    loop do
      player.show_cards
      hit? ? player.hand << deck.deal_card : break
      break if player.busted?
    end
  end

  def dealer_turn
    loop do
      dealer.show_cards
      break if dealer.busted? || dealer.total >= 17
      dealer.hand << deck.deal_card
    end
  end

  def play_hand
    player_turn
    dealer_turn unless player.busted?
  end

  def show_result
    player.show_cards
    dealer.show_cards
    case
    when player.busted?
      puts "#{player.name} busted. Dealer wins!"
    when dealer.busted?
      puts "Dealer busted. #{player.name} wins!"
    when player.total > dealer.total
      puts "#{player.name} wins!"
    when player.total < dealer.total
      puts "Dealer wins!"
    else
      puts "It's a push!"
    end
  end

  def play_again?
    choice = nil
    loop do
      puts "Play another hand? (y, n)"
      choice = gets.chomp.downcase
      break if %w(y n).include?(choice)
      puts "Not a valid choice."
    end
    choice == 'y'
  end
end

Game.new.start