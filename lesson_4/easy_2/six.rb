# If I have the following class:

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# Which one of these is a class method (if any) and how do you know? How would you call a class method?

# self.manufacturer is the class method because it is defined using `self` in the method definition.
# You call the class method by calling the method on the class name like this:

Television.manufacturer