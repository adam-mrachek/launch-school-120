# Which of these two classes has an instance variable and how do you know?

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

# The Pizza class has an instance variable `@name`. 
# Instance variables start with the @ symbol.
# We can also check for instance variables by calling the #instance_variables method on an instance of a class.

fruit = Fruit.new('banana')
zza = Pizza.new('pepperoni')

fruit.instance_variables # => []
zza.instance_variables # => [:@name]