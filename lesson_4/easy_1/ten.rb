# If we have the class below, what would you need to call to create a new instance of this class.

class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

# We need to call `new` on Bag and provide 2 arguments: color and material:

fancy_bag = Bag.new('Tan', 'Leather')