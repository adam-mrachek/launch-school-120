# In the last question we had a module called Speed which contained a go_fast method. 
# We included this module in the Car class as shown below.

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

small_car = Car.new
small_car.go_fast

# => I am a Car and going super fast!

# When we called the go_fast method from an instance of the Car class (as shown below) you might have noticed that the string printed when we go fast includes the name of the type of vehicle we are using. How is this done?
# A: In the #go_fast method, there is a call to `self.class` which refers to the class of the calling object.
# In the case of a Car object, self.class returns 'Car'
# More specifically, `self` refers to the object itself (small_car). Then we call `#class` on the object to find out which class the object is an instance of.
