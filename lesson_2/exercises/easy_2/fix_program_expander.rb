# What is wrong with the following code? What fix(es) would you make?

class Expander
  def initialize(string)
    @string = string
  end

  def to_s
    expand(3) # Changed from `self.expand` to just expand since private methods cannot be called with an explicit caller
  end

  private

  def expand(n)
    @string * n
  end
end

expander = Expander.new('xyz')
puts expander