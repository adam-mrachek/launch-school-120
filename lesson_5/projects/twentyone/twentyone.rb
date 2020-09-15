require 'pry'

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
    hand.sum{ |card| VALUES[card[0]] }
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
      puts "> #{card[0]} of #{card[1]}"
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

  SUITS = %w(Diamonds Hearts Clubs Spades)
  RANKS = %w(2 3 4 5 6 7 8 9 Jack Queen King Ace)
  
  def initialize
    @cards = shuffle
  end

  def shuffle
    @cards = RANKS.product(SUITS).shuffle
  end
end

class Game
  attr_accessor :deck, :player, :dealer

  def initialize
    @deck = Deck.new.cards
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    game_setup
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn
    show_result
  end

  def game_setup
    player.choose_name
  end

  def deal_cards
    2.times do 
      player.hand << deck.pop
      dealer.hand << deck.pop
    end
  end

  def show_initial_cards
    puts "Dealer shows:"
    puts "> #{dealer.hand[0][0]} of #{dealer.hand[0][1]}"
    puts "Total: #{Hand::VALUES[dealer.hand[0][0]]}"
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
      hit? ? player.hand << deck.pop : break
      break if player.busted?
    end
  end

  def dealer_turn
    loop do
      dealer.show_cards
      break if dealer.busted? || dealer.total >= 17
      dealer.hand << deck.pop
    end
  end

  def show_result
    player.show_cards
    dealer.show_cards
    if player.busted? || player.total < dealer.total
      puts "Dealer wins!"
    elsif dealer.busted? || player.total > dealer.total
      puts "#{player.name} wins!"
    end
  end
end

Game.new.start