# Assume you have the code below with the following output:

# => Home 1 is cheaper
# => Home 2 is more expensive

# Modify the House class so that the above program will work. You are permitted to define only one new method in House.

class House
  attr_reader :price
  include Comparable # Second solution

  def initialize(price)
    @price = price
  end

  # These two methods were part of my initial solution
  # def <(other_home)
  #   self.price < other_home.price
  # end

  # def >(other_home)
  #   self.price > other_home.price
  # end

  def <=>(other) # Second solution
    price <=> other.price
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1