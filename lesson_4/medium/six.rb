# If we have these two methods:

# class Computer
#   attr_accessor :template

#   def create_template
#     @template = "template 14231"
#   end

#   def show_template
#     template
#   end
# end

# and

class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    self.template
  end
end

# What is the difference in the way the code works?

# There is no difference in the end result, but...

# In the first class, `template` is being changed directly in #create_template since it's using `@template` instead of using a setter method.
# #show_template is using the getter method to read the `template` instance variable.

# In the second class, `template` is being changed using the setter method in #create_template by calling `self` on template.
# #show_template is using `self` to read the `template` variable even though it's not needed and, in general, not recommended per Ruby Style Guide.
