class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# What would happen if I called the methods like shown below?

tv = Television.new
tv.manufacturer # => This would throw a no method error because there is no #manufacturer instance method (tv is an instance of Television). There is only a `manufacturer` class method.
tv.model # => This would execute the logic within the #model instance method.

Television.manufacturer # => This would execute the logic in the `self.manufacturer` class method since we can calling a method directly on the Television class.
Television.model # => This would throw a no method error because there is no `model` class method. There is only a `model` instance method.