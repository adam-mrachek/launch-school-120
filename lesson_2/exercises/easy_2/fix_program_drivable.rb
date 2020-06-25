# Correct the following program so it will work properly. 
# Assume that the Car class has a complete implementation; just make the smallest possible change to ensure that cars have access to the drive method.\

module Drivable
  def drive # changed from self.drive to make the method available to Car objects.
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive