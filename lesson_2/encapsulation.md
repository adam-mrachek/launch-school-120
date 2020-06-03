# Encapsulation

Encapsulation is a pattern for capturing an object's intent and only exposing the components necessary for interacting with it. It lets us hide the internal representation of an object from the outside and only expose the methods and properties that users of the object need. This is done using public methods.

Example:
```ruby
class Dog
  attr_reader :nickname

  def initialize(n)
    @nickname = n
  end

  def change_nickname(n)
    self.nickname = n
  end

  def greeting
    "#{nickname.capitalize} says Woof Woof!"
  end

  private
    attr_writer :nickname
end

dog = Dog.new("rex")
dog.change_nickname("barny") # changed nickname to "barny"
puts dog.greeting # "Barney sayd Woof Woof!"
dog.nickname = "yeller" # raises an error because `nickname` is a private method
```
In the code above, we change the dog's nickname by calling the `change_nickname` method - we don't need to know the implementation details of the `Dog` class or this method. Same goes for the `greeting` method.

Note that prepending `self` is required when calling private setter methods because, if you didn't, Ruby would think you were creating a local variable.

Note: Ideally, Classes shoudl have as few public methods as possible. Doing so protects data from undesired changes and simplies the class.