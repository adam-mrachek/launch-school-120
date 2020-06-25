class Pet
  attr_accessor :owner
  attr_reader :type, :name

  def initialize(type, name, owner = nil)
    @type = type
    @name = name.capitalize
    @owner = owner
  end

  def to_s
    "a #{type} named #{name}"
  end
end

class Owner
  attr_accessor :pets, :owner
  attr_reader :name

  def initialize(name)
    @name = name
    @pets = []
  end

  def number_of_pets
    pets.count
  end
end

class Shelter
  attr_reader :adoptions

  def initialize
    @adoptions = {}
    @current_rescues = {}
  end

  def intake(pet)
    @current_rescues[pet.name] = pet
  end

  def adopt(owner, pet)
    owner.pets << pet
    @adoptions[owner.name] ||= owner
    @current_rescues.delete(pet.name)
  end

  def print_adoptions
    @adoptions.each_pair do |name, owner|
      puts "#{name} has adopted the following pets:"
      owner.pets.each do |pet|
        puts pet
      end
      puts ""
    end
  end

  def print_unadopted_number
    puts "The shelter currently has #{@current_rescues.length} unadopted pets."
  end

  def print_unadopted
    puts "The Animal Shelter has the following unadopted pets:"
    @current_rescues.each_value do |pet|
      puts pet
    end
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')
asta         = Pet.new('cat', 'Asta')
laddie       = Pet.new('cat', 'laddie')
fluffy       = Pet.new('bearded dragon', 'fluffy')
kat          = Pet.new('dog', 'kat')
ben          = Pet.new('parakeet', 'ben')
chatterbox   = Pet.new('dog', 'chatterbox')
bluebell     = Pet.new('fish', 'bluebell')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.intake(butterscotch)
shelter.intake(pudding)
shelter.intake(darwin)
shelter.intake(kennedy)
shelter.intake(sweetie)
shelter.intake(molly)
shelter.intake(chester)
shelter.intake(asta)
shelter.intake(laddie)
shelter.intake(fluffy)
shelter.intake(kat)
shelter.intake(ben)
shelter.intake(chatterbox)
shelter.intake(bluebell)
shelter.print_unadopted_number

shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts ""
shelter.print_unadopted
shelter.print_unadopted_number