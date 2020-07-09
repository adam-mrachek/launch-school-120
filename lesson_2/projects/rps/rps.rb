class Player
  attr_accessor :move, :name

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
      puts "Please enter your move (rock, paper, or scissors):"
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  COMPUTER_NAMES = ['Number 5', 'T-1000', 'Wall-e', 'R2D2', 'Hal']

  def set_name
    self.name = COMPUTER_NAMES.sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class Move
  VALUES = ['rock', 'paper', 'scissors']

  def initialize(value)
    @value = value
  end

  def to_s
    @value
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def scissors?
    @value == 'scissors'
  end

  def >(other_move)
    if rock?
      other_move.scissors?
    elsif paper?
      other_move.rock?
    elsif scissors?
      other_move.paper?
    end
  end

  def <(other_move)
    if rock?
      other_move.paper?
    elsif paper?
      other_move.scissors?
    elsif scissors?
      other_move.rock?
    end
  end
end

class RPSGame
  attr_accessor :human, :computer, :score

  WINNING_SCORE = 3

  def initialize
    @human = Human.new
    @computer = Computer.new
    @score = {}
  end

  def reset_score
    self.score["#{human}"] = 0
    self.score["#{computer}"] = 0
  end

  def update_score(player)
    score["#{player}"] += 1 if player
  end

  def display_overall_winner
    puts "#{score.key(WINNING_SCORE)} wins the game!"
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
    else
      nil
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
    puts "#{human}: #{score["#{human}"]}"
    puts "#{computer}: #{score["#{computer}"]}"
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
        break if score.values.include?(WINNING_SCORE)
      end
       display_overall_winner
       break unless play_again?
    end

    display_goodbye_message
  end

  def play_again?
    options = ['y', 'n']
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
