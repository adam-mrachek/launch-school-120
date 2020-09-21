module Displayable
  def clear
    system('clear') || system('cls')
  end

  def empty_line
    puts ""
  end

  def horizontal_rule
    puts "------------------------------------------------------------"
  end

  def star_line
    puts "**********************"
  end

  def display_welcome_message
    clear
    star_line
    puts "Welcome to Twenty One!"
    star_line
    empty_line
    puts "The player with the highest score "\
         "without going over #{TwentyOne::WINNING_SCORE} wins!"
    horizontal_rule
    empty_line
  end

  def diplay_player_greeting
    clear
    empty_line
    puts "Hi, #{player.name}! Let's play!"
    empty_line
  end

  def display_dealing_cards
    puts "Dealing cards..."
    sleep 1.0
    empty_line
  end

  def display_player_hits(player)
    puts "#{player.name} hits!"
  end
end

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
    total > TwentyOne::WINNING_SCORE
  end

  def total
    total = hand.sum { |card| VALUES[card.rank] }

    hand.select { |card| card.rank == 'Ace' }.count.times do
      break if total <= TwentyOne::WINNING_SCORE
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
      puts "Please enter your name:"
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

  def add_card(card)
    hand << card
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

class TwentyOne
  attr_accessor :deck, :player, :dealer

  include Displayable

  WINNING_SCORE = 21
  DEALER_STAY = 17

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    game_setup
    loop do
      display_dealing_cards
      deal_cards
      play_hand
      show_final_cards
      show_result
      play_again? ? reset : break
    end
  end

  def game_setup
    display_welcome_message
    player.choose_name
    diplay_player_greeting
  end

  def reset
    self.deck = Deck.new
    player.hand = []
    dealer.hand = []
    clear
  end

  def deal_cards
    2.times do
      player.add_card(deck.deal_card)
      dealer.add_card(deck.deal_card)
    end
  end

  def show_face_up_card
    puts "Dealer shows:"
    puts "> #{dealer.hand[0]}"
    puts "Total: #{Hand::VALUES[dealer.hand[0].rank]}"
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

  def stay?
    !hit?
  end

  def player_turn
    loop do
      show_face_up_card
      player.show_cards

      break unless hit?
      clear
      display_player_hits(player)
      player.add_card(deck.deal_card)

      break if player.busted?
    end
  end

  def dealer_turn
    puts "Dealer's turn..."

    loop do
      break if dealer.busted? || dealer.total >= DEALER_STAY
      sleep 1.0
      display_player_hits(dealer)
      dealer.add_card(deck.deal_card)
      sleep 1.5
      dealer.show_cards
    end
  end

  def play_hand
    player_turn
    clear
    dealer_turn unless player.busted?
  end

  def show_final_cards
    player.show_cards
    dealer.show_cards
  end

  def show_result
    if player.busted?
      puts "** #{player.name} busted. Dealer wins! **"
    elsif dealer.busted?
      puts "** Dealer busted. #{player.name} wins! **"
    elsif player.total > dealer.total
      puts "** #{player.name} wins! **"
    elsif player.total < dealer.total
      puts "** Dealer wins! **"
    else
      puts "** It's a push! **"
    end
  end

  def play_again?
    choice = nil
    loop do
      empty_line
      puts "Play another hand? (y, n)"
      choice = gets.chomp.downcase
      break if %w(y n).include?(choice)
      puts "Not a valid choice."
    end
    choice == 'y'
  end
end

TwentyOne.new.start
