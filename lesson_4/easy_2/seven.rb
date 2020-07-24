# If we have a class such as the one below:

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# Explain what the @@cats_count variable does and how it works. What code would you need to write to test your theory?

# The @@cats_count variable keeps track of the number of Cat objects that have been created. 
# It starts at 0 is incremented by 1 in the #initialize method.
# We can test it by creating several Cat objects and checking the @@cats_count variable along the way.

puts Cat.cats_count # => 0
tabby = Cat.new('tabby')
siamese = Cat.new('siamese')
ragdoll = Cat.new('ragdoll')
puts Cat.cats_count # => 3