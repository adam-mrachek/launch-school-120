# If we have a class such as the one below...
# You can see in the make_one_year_older method we have used self. What does self refer to here?

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

# `self` refers to the calling (instance) object
# So if we have an instance of the Cat class:

fluffy = Cat.new('Tabby')

# And we call #make_one_year_older

fluffy.make_one_year_older

# `self` refers to `fluffy` which is the instance that called the method.
# So we would be adding 1 year to the `age` instance variable of the `fluffy` object.
