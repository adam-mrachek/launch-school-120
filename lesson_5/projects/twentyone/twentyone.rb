class Player
  def initialize
    # what would the "data" or "states" of a Player object entail?
    # maybe cards? a name?
  end

  def hit

  end

  def stay
  end

  def busted?

  end

  def total
    # definitely looks like we need to know about "cards" to produce some total
  end
end

class Dealer
  def initialize

  end

  def deal 

  end

  def hit

  end

  def stay

  end

  def busted?

  end

  def total?

  end
end

class Deck
  SUITS = %(Diamonds Hearts Clubs Spades)
  VALUES = %(2 3 4 5 6 7 8 9 Jack Queen King Ace)
  
  def initialize
    # we need some data structure to keep tack of cards
    # array, hash, something else?
  end

  def deal
    # does the dealer or deck deal?
  end
end

class Game
  def start
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn
    show_result
  end

  def deal_cards

  end
end

Game.new.start