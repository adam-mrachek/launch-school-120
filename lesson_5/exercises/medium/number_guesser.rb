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

  def initialize
    @winning_number = rand(1..100)
    @guesses = 7
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
      puts "Enter a number between 1 and 100:"
      guess = gets.chomp.to_i
      break if (1..100).include?(guess)

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

game = GuessingGame.new
game.play