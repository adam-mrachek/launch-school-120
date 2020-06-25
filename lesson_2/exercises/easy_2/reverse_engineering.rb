# Write a class that will display:

# => ABC
# => xyz

# when the following code is run:

# my_data = Transform.new('abc')
# puts my_data.uppercase
# puts Transform.lowercase('XYZ')

class Transform
  attr_reader :str

  def initialize(str)
    @str = str
  end

  def self.lowercase(str)
    str.upcase
  end

  def uppercase
    str.downcase
  end
end

my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')