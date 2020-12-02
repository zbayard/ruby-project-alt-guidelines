class User < ActiveRecord::Base
  has_many :orders
  
  
# VIEW MENU(read) ********CLI******
# put out all roasts by name & price
def view_menu #returns an array of two separate arrays, is this what we want? 
  Roast.all.map{|roast| [roast.name, roast.price]}
end

# SEE CURRENT CART(read)
# have the ability to see an empty cart or a cart in progress aka false
def current_cart
  orders.find_or_create_by(checked_out: false)
end

# def display_cart
#     self.current_cart.

# ADD TO CART(create)
# create a new order instance(check out false)
def add_to_cart(roast_inst)
  CoffeeOrder.create(order: self.current_cart, roast: roast_inst)
end

#DELETE FROM CART(delete)
# delete an item from cart

# PLACE ORDER(update)
# changing check out to true(maybe add an adress column to user & incorporate that)

# SEE PAST ORDERS(read)
# be able to see a list of all orders with a check out of true




end