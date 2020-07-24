# If we have this class:

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

# What would happen if we added a play method to the Bingo class, keeping in mind that there is already a method of this name in the Game class that the Bingo class inherits from.

# Ruby will always first look for a method to resolve in the class of the object that the method was called on.
# So if a #play method were added to Bingo, ruby would execute that method instead of the #play method in Game.