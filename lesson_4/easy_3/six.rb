# If we have a class such as the one below:

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

# In the make_one_year_older method we have used self. What is another way we could write this method so we don't have to use the self prefix?
# We can use `@age` instead of `self.age` since `self` is referencing the setter method for `age` so we can use `self` and `@` interchangeably.