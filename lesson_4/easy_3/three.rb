# When objects are created they are a separate realization of a particular class.

# Given the class below, how do we create two different instances of this class, both with separate names and ages?

class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

# Answer:

instance1 = AngryCat(3, "Garfield")
instance2 = AngryCat(1, "Grumpy")

# These are two different instances of AngryCat created by called `new` on AngryCat and passing in age and name to the initialize method.