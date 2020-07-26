# In the last question we had the following classes:

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def self.hi
    greeting = Greeting.new
    greeting.greet("Hi")
  end

  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# If we call Hello.hi we get an error message. How would you fix this?

# We start by defining a class method `self.hi`.
# To use the #greet method in the Greeting class we need to instantiate a Greeting object and then call #greet to return a greeting
# See line 10 for example.

