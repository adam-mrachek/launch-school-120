module Utilities
  def joinor(array, delimeter=", ", word='or')
    case array.size
    when 0 then ''
    when 1 then array.first
    when 2 then array.join(" #{word} ")
    when (3..)
      array[-1] = "#{word} #{array.last}"
      array.join(delimeter)
    end
  end
end

module Displayable
  def clear
    system('clear') || system('cls')
  end

  def empty_line
    puts ""
  end

  def horizontal_rule
    puts "-------------------------------------"
  end

  def star_line
    puts "*****************"
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
      return squares.first.marker if three_identical_markers?(squares)
    end
    nil
  end

  def at_risk_line(marker)
    WINNING_LINES.find do |line|
      line.count { |square| @squares[square].marker == marker } == 2 &&
        line.count { |square| @squares[square].marker.nil? } == 1
    end
  end

  def at_risk_square(marker)
    at_risk_line(marker)&.each do |square|
      return square if @squares[square].marker.nil?
    end
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
  attr_accessor :score
  attr_reader :name, :marker, :player_type

  include Displayable

  def initialize(marker, player_type = :human)
    @marker = marker
    @player_type = player_type
    @name = ''
    @score = 0
  end

  def to_s
    name
  end

  def human?
    @player_type == :human
  end

  def choose_player_name
    name = nil
    loop do
      puts "Please enter your name:"
      name = gets.chomp
      break unless name.strip.empty?
      puts "Sorry, name can't be blank."
    end
    name
  end

  def set_name
    @name = if human?
              choose_player_name
            else
              ['Woody', 'Buzz Lightyear', 'Olaf', 'Moana', 'Maui'].sample
            end
  end
end

class TTTGame
  attr_reader :board, :player, :computer, :game_starter

  include Displayable
  include Utilities

  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  FIRST_TO_MOVE = 'choose'
  WINNING_SCORE = 5

  def initialize
    @board = Board.new
    @player = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER, :computer)
  end

  def play
    clear
    display_welcome_message
    choose_game_conditions
    main_game
    display_goodbye_message
  end

  private

  def first_player
    case FIRST_TO_MOVE
    when 'choose' then choose_first_player
    when HUMAN_MARKER then HUMAN_MARKER
    when COMPUTER_MARKER then COMPUTER_MARKER
    end
  end

  def choose_player_names
    player.set_name
    computer.set_name
  end

  def choose_first_player
    choice = nil
    loop do
      empty_line
      puts "Select first player ('h' for human, 'c' for computer)"
      choice = gets.chomp.downcase
      break if ['h', 'c'].include?(choice)
      puts "Invalid choice."
    end

    choice == 'h' ? HUMAN_MARKER : COMPUTER_MARKER
  end

  def choose_game_conditions
    choose_player_names
    @game_starter = @current_marker = first_player
  end

  def display_welcome_message
    clear
    horizontal_rule
    puts "Welcome to Tic Tac Toe!"
    puts "First player to #{WINNING_SCORE} wins the game."
    horizontal_rule
  end

  def start_game_prompt
    empty_line
    puts "Press enter to start the game."
    gets.chomp
  end

  def human_moves
    choice = nil
    loop do
      empty_line
      puts "Enter #{joinor(board.open_squares)} to select a square."
      choice = gets.chomp
      break if ('1'..'9').include?(choice) && board[choice.to_i].unmarked?
      puts "Sorry, not a valid choice."
    end
    board[choice.to_i] = player.marker
  end

  def computer_moves
    choice = if board.at_risk_square(COMPUTER_MARKER)
               board.at_risk_square(COMPUTER_MARKER)
             elsif board.at_risk_square(HUMAN_MARKER)
               board.at_risk_square(HUMAN_MARKER)
             elsif board.open_squares.include?(5)
               5
             else
               board.open_squares.sample
             end
    board[choice] = computer.marker
  end

  def player_move
    loop do
      clear_screen_and_display_board
      current_player_moves
      break if board.someone_won? || board.full?
    end
  end

  def main_game
    loop do
      start_game_prompt
      play_round
      display_game_winner
      break unless play_again?
      reset_game
    end
  end

  def play_round
    loop do
      player_move
      update_score
      display_result
      break if game_winner?
      reset_round
    end
  end

  def clear_screen_and_display_board
    clear
    display_score
    board.display
  end

  def display_board
    display_score
    board.display
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

  def round_winner
    if player.marker == board.winning_marker
      player
    elsif computer.marker == board.winning_marker
      computer
    end
  end

  def update_score
    case round_winner
    when player then player.score += 1
    when computer then computer.score += 1
    end
  end

  def display_score
    puts "SCORE"
    puts "#{player}: #{player.score}"
    puts "#{computer}: #{computer.score}"
    empty_line
  end

  def reset_score
    player.score = 0
    computer.score = 0
  end

  def display_result
    clear_screen_and_display_board

    case round_winner
    when player
      puts "** You won the round! **"
    when computer
      puts "** #{computer.name} won the round! **"
    else
      puts "It's a tie!"
    end
  end

  def game_winner?
    player.score == WINNING_SCORE || computer.score == WINNING_SCORE
  end

  def display_game_winner
    if player.score == WINNING_SCORE
      puts "#{player} wins the game!"
    else
      puts "#{computer} wins the game!"
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

  def reset_round
    puts "Press enter to start next round."
    gets.chomp
    board.reset
    @current_marker = @game_starter
  end

  def reset_game
    clear
    star_line
    puts "Let's play again!"
    star_line
    board.reset
    reset_score
    @current_marker = first_player
    @game_starter = @current_marker
  end
end

game = TTTGame.new
game.play
