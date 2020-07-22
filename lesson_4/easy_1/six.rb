# What could we add to the class below to access the instance variable @volume?

class Cube
  attr_reader :volume

  def initialize(volume)
    @volume = volume
  end
end

# We could add the getter method below to the class:

def volume
  @volume
end
 
# or use the attr_reader as added to the class above.