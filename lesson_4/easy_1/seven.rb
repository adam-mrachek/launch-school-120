# What is the default return value of to_s when invoked on an object? Where could you go to find out if you want to be sure?

# By default, to_s will prtin an object's class and an encoding of the object_id

# For example:

class Car
end

car = Car.new
car.to_s # => #<Car:0x00007fe40d11a3e8>