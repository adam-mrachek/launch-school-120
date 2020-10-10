class GuessingGame
  attr_reader :winning_number

  WIN_OR_LOSE = {
    high:  :lose,
    low:   :lose,
    match: :win
  }

  RESULT_OF_GUESS = {
    high:  "Your guess is too high.",
    low:   "Your guess is too low.",
    match: "You guessed the number!"
  }

  RESULT_OF_GAME = {
    win: "You won!",
    lose: "You're out of guesses. You lost!"
  }

  def initialize(low_number, high_number)
    @low_number = low_number
    @high_number = high_number
    @winning_number = rand(low_number..high_number)
    @guesses = Math.log2(high_number - low_number).to_i + 1
  end

  def evaluate(guess)
    if guess > winning_number
      :high
    elsif guess < winning_number
      :low
    else
      :match
    end
  end

  def winner?(result)
    result == :match
  end

  def player_guess
    guess = nil
    loop do
      puts "Enter a number between #{@low_number} and ##{@high_number}:"
      guess = gets.chomp.to_i
      break if (@low_number..@high_number).include?(guess)

      puts "Invalid guess."
    end
    @guesses -= 1
    guess
  end

  def play
    result = nil
    @guesses.downto(1) do
      puts "You have #{@guesses} guesses remaining."
      result = evaluate(player_guess)

      puts RESULT_OF_GUESS[result]
      break if winner?(result)
    end

    puts RESULT_OF_GAME[WIN_OR_LOSE[result]]
  end
end

game = GuessingGame.new(200, 2000)
game.play