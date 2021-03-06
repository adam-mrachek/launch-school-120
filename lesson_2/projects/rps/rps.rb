module Displayable
  def empty_line
    puts
  end

  def dash_border
    puts "---------"
  end

  def clear_screen
    system('clear') || system('cls')
  end
end

class Move
  attr_reader :value, :beats, :player

  @@all = []

  def initialize(player)
    @player = player
  end

  def self.all
    @@all
  end

  def to_s
    @value
  end

  def >(other_move)
    beats.include?(other_move.value)
  end

  def <(other_move)
    other_move.beats.include?(value)
  end
end

class Rock < Move
  def initialize(player)
    super
    @value = 'rock'
    @beats = ['scissors', 'lizard']
  end
end

class Paper < Move
  def initialize(player)
    super
    @value = 'paper'
    @beats = ['rock', 'spock']
  end
end

class Scissors < Move
  def initialize(player)
    super
    @value = 'scissors'
    @beats = ['paper', 'lizard']
  end
end

class Lizard < Move
  def initialize(player)
    super
    @value = 'lizard'
    @beats = ['paper', 'spock']
  end
end

class Spock < Move
  def initialize(player)
    super
    @value = 'spock'
    @beats = ['rock', 'scissors']
  end
end

class Player
  attr_accessor :move, :name, :score

  MOVES = {
    'r' => 'Rock',
    'p' => 'Paper',
    'sc' => 'Scissors',
    'l' => 'Lizard',
    'sp' => 'Spock'
  }

  def initialize
    set_name
  end

  def to_s
    name
  end
end

class Human < Player
  def set_name
    n = nil
    loop do
      puts "Enter your name:"
      n = gets.chomp
      break unless n.empty?
      puts "Please enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "> Choose your move: (r)ock, (p)aper, (sc)issors, (l)izard, (sp)ock."
      choice = gets.chomp
      break if MOVES.keys.include?(choice)
    end
    move_class = Object.const_get(MOVES[choice])
    self.move = move_class.new(self)
  end
end

class Computer < Player
  COMPUTER_NAMES = ['Number 5', 'T-1000', 'Wall-e', 'R2D2', 'Hal']

  def set_name
    self.name = COMPUTER_NAMES.sample
  end

  def choose
    move_class = Object.const_get(MOVES.values.sample)
    self.move = move_class.new(self)
  end
end

class RPSGame
  include Displayable

  attr_accessor :human, :computer

  WINNING_SCORE = 3

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def reset_score
    human.score = 0
    computer.score = 0
  end

  def update_score(player)
    player.score += 1 if player
  end

  def overall_winner?
    human.score == WINNING_SCORE || computer.score == WINNING_SCORE
  end

  def overall_winner
    return human if human.score == WINNING_SCORE
    return computer if computer.score == WINNING_SCORE
  end

  def display_overall_winner
    puts "#{overall_winner} wins the game!"
    empty_line
  end

  def display_welcome_message
    empty_line
    puts "Welcome to Rock, Paper, Scissors!"
    puts "First player to #{WINNING_SCORE} wins!"
    empty_line
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors! Goodbye!"
  end

  def choose_moves
    human.choose
    computer.choose
  end

  def display_moves
    empty_line
    puts "You chose #{human.move}."
    puts "#{computer} chose #{computer.move}."
    empty_line
  end

  def update_move_history
    Move.all << [human.move, computer.move]
  end

  def winning_player
    if human.move > computer.move
      human
    elsif human.move < computer.move
      computer
    end
  end

  def display_winner(winner)
    if winner
      puts "#{winner.name} wins the round!"
    else
      puts "It's a tie!"
    end
  end

  def display_score
    dash_border
    puts "Score:"
    puts "#{human}: #{human.score}"
    puts "#{computer}: #{computer.score}"
    dash_border
    empty_line
  end

  def view_history?
    choice = nil
    loop do
      puts "> Would you like to view all player moves from this session? (y/n)"
      choice = gets.chomp.downcase
      break if ['y', 'n'].include?(choice)
      puts "Sorry, that's not a valid choice."
    end
    choice == 'y'
  end

  def display_history
    empty_line
    puts "Player move history by round:"
    Move.all.each_with_index do |moves, i|
      dash_border
      puts "Round #{i + 1}:"
      moves.each do |move|
        puts "#{move.player.name}: #{move.value}"
      end
    end
    empty_line
  end

  def play_again?
    options = %w(y n)
    choice = nil
    loop do
      puts "> Would you like to play again? (y/n)"
      choice = gets.chomp.downcase
      break if options.include?(choice)
      puts "Invalid input. Choose 'y' or 'n'."
    end
    choice == 'y'
  end

  def game_round
    loop do
      choose_moves
      update_move_history
      display_moves
      display_winner(winning_player)
      update_score(winning_player)
      display_score
      break if overall_winner?
    end
  end

  def play
    display_welcome_message

    loop do
      reset_score
      game_round
      display_overall_winner
      display_history if view_history?
      break unless play_again?
      clear_screen
    end

    display_goodbye_message
  end
end

RPSGame.new.play
