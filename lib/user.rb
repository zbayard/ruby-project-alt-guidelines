class User < ActiveRecord::Base
  has_many :orders
  
    def see_past_orders
      self.orders.where(checked_out: true)
    end
  
    def my_cart
      self.orders.find_or_create_by(checked_out: false)
    end

    def display_cart
      self.my_cart.coffee_orders.each do |coffee_order|
        puts "ID:#{coffee_order.id} - #{coffee_order.roast.name}"
      end
    end

    def add_to_cart(roast_inst)
      CoffeeOrder.create(order: self.my_cart, roast: roast_inst)
    end

    def delete_from_cart(coffee_order_id)
      CoffeeOrder.destroy(coffee_order_id)
    end

    def place_order
      puts "You're all checked out!"
      self.my_cart.update(checked_out: true)
    end

end