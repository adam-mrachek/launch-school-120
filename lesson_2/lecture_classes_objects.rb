class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parse_full_name(full_name)
  end

  def name
    last_name.empty? ? "#{first_name}" : "#{first_name} #{last_name}"
  end

  def name=(full_name)
    parse_full_name(full_name)
  end

  def to_s
    self.name
  end

  private

  def parse_full_name(full_name)
    parts = full_name.split
    self.first_name = parts.first
    self.last_name = parts.size > 1 ? parts.last : ''
  end
end

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

p bob.name == rob.name # Problem 4

puts "The person's name is: #{bob}" # Prints: The person's name is: #<Person:0x00007f95bd857708> without custom to_s method
puts "The person's name is: #{bob}" # Prints: The person's name is: Robert Smith. with custom to_s method.