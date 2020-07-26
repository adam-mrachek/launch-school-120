# What is used in this class but doesn't add any value?

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end

end

# The `return` in `self.information` is not needed because Ruby automatically returns the last line of any method.
# There is only one line in the method so it will be returned automatically.