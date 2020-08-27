require 'pry'

module Displayable
  def clear
    system 'clear'
  end

  def empty_line
    puts ""
  end
end

class Board
  include Displayable

  WINNING_LINES = [
    [1, 2, 3], [4, 5, 6], [7, 8, 9],
    [1, 4, 7], [2, 5, 8], [3, 6, 9],
    [1, 5, 9], [3, 5, 7]
  ]

  def initialize
    @squares = {}
    reset
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def display
    clear
    empty_line
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}  "
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}  "
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}  "
    puts "     |     |"
    empty_line
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def open_squares
    @squares.select { |_, square| square.unmarked? }.keys
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def [](num)
    @squares[num]
  end

  def full?
    open_squares.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  attr_accessor :marker

  INITIAL_MARKER = nil

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    marker || " "
  end

  def marked?
    marker != INITIAL_MARKER
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_reader :name, :marker, :player_type

  def initialize(marker, player_type = :human)
    @marker = marker
    @player_type = player_type
    @name = choose_name
  end

  def human?
    @player_type == :human
  end

  def choose_name
    name = nil
    if human?
      loop do
        puts "Please enter your name:"
        name = gets.chomp
        break unless name.empty?
        puts "Sorry, name can't be blank."
      end
    else
      name = ['Woody', 'Buzz Lightyear', 'Olaf', 'Moana', 'Maui'].sample
    end
    @name = name
  end
end

class TTTGame
  attr_reader :board, :player, :computer

  include Displayable

  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  FIRST_TO_MOVE = HUMAN_MARKER

  def initialize
    @board = Board.new
    @player = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER, :computer)
    @current_marker = FIRST_TO_MOVE
  end

  def play
    display_welcome_message
    main_game
    display_goodbye_message
  end

  private

  def display_welcome_message
    clear
    puts "---------------------------------------"
    puts "Hi, #{player.name}. Welcome to Tic Tac Toe!"
    puts "---------------------------------------"
  end

  def human_moves
    choice = nil
    loop do
      empty_line
      puts "Enter 1-9 to select a square."
      choice = gets.chomp.to_i
      break if (1..9).include?(choice) && board[choice].unmarked?
      puts "Sorry, not a valid choice."
    end
    board[choice] = player.marker
  end

  def computer_moves
    choice = board.open_squares.sample
    board[choice] = computer.marker
  end

  def player_move
    loop do
      board.display
      current_player_moves
      break if board.someone_won? || board.full?
    end
  end

  def main_game
    loop do
      start_game_prompt
      player_move
      display_result
      break unless play_again?
      reset_game
    end
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end

  def display_result
    board.display
    winner = board.winning_marker

    if winner == player.marker
      puts "** You won the game! **"
    elsif winner == computer.marker
      puts "** #{computer.name} won the game! **"
    else
      puts "It's a tie!"
    end
  end

  def display_goodbye_message
    puts "Thanks for playing. Goodbye!"
  end

  def play_again?
    choice = nil
    loop do
      puts "Play again? (y/n)"
      choice = gets.chomp.downcase
      break if %w(y n).include?(choice)
      puts "Not a valid choice."
    end
    choice == 'y'
  end

  def reset_game
    clear
    puts "*****************"
    puts "Let's play again!"
    puts "*****************"
    board.reset
    @current_marker = FIRST_TO_MOVE
  end

  def start_game_prompt
    empty_line
    puts "Press enter to start the game."
    gets.chomp
  end
end

game = TTTGame.new
game.play
