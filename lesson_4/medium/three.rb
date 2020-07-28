# In the last question Alan showed Alyssa this code which keeps track of items for a shopping cart application:

class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    quantity = updated_count if updated_count >= 0
  end
end

# Alyssa noticed that this will fail when update_quantity is called. 
# Since quantity is an instance variable, it must be accessed with the @quantity notation when setting it. One way to fix this is to change attr_reader to attr_accessor and change quantity to self.quantity.

# Is there anything wrong with fixing it this way?

# Simply changing `attr_reader` to `attr_accessor` would also make it possible to change `@product_name` which may not be wanted.
# Also, with `attr_accessor` we are allowing @quantity to be changed directly via a public interface which can be dangerous.
# It's preferable to update the quantity through a method like #update_quantity so you can build in protections/validations.