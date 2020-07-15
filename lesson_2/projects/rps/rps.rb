class Move
  attr_reader :value, :beats

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
  def initialize
    @value = 'rock'
    @beats = ['scissors', 'lizard']
  end
end

class Paper < Move
  def initialize
    @value = 'paper'
    @beats = ['rock', 'spock']
  end
end

class Scissors < Move
  def initialize
    @value = 'scissors'
    @beats = ['paper', 'lizard']
  end
end

class Lizard < Move
  def initialize
    @value = 'lizard'
    @beats = ['paper', 'spock']
  end
end

class Spock < Move
  def initialize
    @value = 'spock'
    @beats = ['rock', 'scissors']
  end
end

class Player
  attr_accessor :move, :name, :score

  MOVES = {
      'r' => Rock.new,
      'p' => Paper.new,
      'sc' => Scissors.new,
      'l' => Lizard.new,
      'sp' => Spock.new
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
      puts "Choose your move: (r)ock, (p)aper, (sc)issors, (l)izard, (sp)ock."
      choice = gets.chomp
      break if MOVES.keys.include?(choice)
    end
    self.move = MOVES[choice]
  end
end

class Computer < Player
  COMPUTER_NAMES = ['Number 5', 'T-1000', 'Wall-e', 'R2D2', 'Hal']

  def set_name
    self.name = COMPUTER_NAMES.sample
  end

  def choose
    self.move = MOVES[MOVES.keys.sample]
  end
end

class RPSGame
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
    human if human.score == WINNING_SCORE
    computer if computer.score == WINNING_SCORE
  end

  def display_overall_winner
    puts "#{overall_winner} wins the game!"
  end

  def display_welcome_message
    puts
    puts "Welcome to Rock, Paper, Scissors!"
    puts "First player to #{WINNING_SCORE} wins!"
    puts
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors! Goodbye!"
  end

  def display_moves
    puts
    puts "You chose #{human.move}."
    puts "The computer chose #{computer.move}."
    puts
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
    puts "---------"
    puts "Score:"
    puts "#{human}: #{human.score}"
    puts "#{computer}: #{computer.score}"
    puts "---------"
  end

  def play
    display_welcome_message

    loop do
      reset_score
      loop do
        human.choose
        computer.choose
        display_moves
        display_winner(winning_player)
        update_score(winning_player)
        display_score
        break if overall_winner?
      end
      display_overall_winner
      break unless play_again?
    end

    display_goodbye_message
  end

  def play_again?
    options = %w(y n)
    choice = nil
    loop do
      puts "Would you like to play again? (y/n)"
      choice = gets.chomp.downcase
      break if options.include?(choice)
      puts "Invalid input. Choose 'y' or 'n'."
    end
    choice == 'y'
  end
end

RPSGame.new.play
