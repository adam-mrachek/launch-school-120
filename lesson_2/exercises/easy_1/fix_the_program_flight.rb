# Consider the following class definition...
# There is nothing technically incorrect about this class, but the definition may lead to problems in the future. How can this class be fixed to be resistant to future problems?

class Flight
  attr_accessor :database_handle

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end

# `database_handle` should probably only be readable outside the class, not writable.
# So we could either make `attr_writer` private or remove the functionality altogether based on the needs of the app.