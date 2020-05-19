class Cat
  @@all = 0
  
  def initialize
    @@all += 1
  end

  def self.total
    puts @@all
  end
end

kitty1 = Cat.new
kitty2 = Cat.new

Cat.total