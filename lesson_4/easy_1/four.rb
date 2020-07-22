# If we have a class AngryCat how do we create a new instance of this class?

# The AngryCat class might look something like this:

class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end

# We can create an new instance like this:

AngryCat.new

# we can save a new instance to a variable like this:

cat = AngryCat.new