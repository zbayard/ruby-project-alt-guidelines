class User < ActiveRecord::Base
    has_many :orders

    @@prompt = TTY::Prompt.new


    def self.login_user
      puts "Enter your username."
      userName = gets.chomp
      puts "Thanks- Enter your password."
      passWord = gets.chomp

      user = User.find_by(username: userName, password: passWord)

      if user.nil?
        puts "That account doesn't exist yet!"
      else
        user
      end
    end

    def self.register_user
      puts "Create your username."
      userName = gets.chomp
      puts "Great! What's your password?"
      passWord = gets.chomp

      user = User.find_by(username: userName)

      if user
        puts "Sorry, that username already exists."
      else
        User.create(username: userName, password: passWord)
      end
    end
    
    def past_orders
      self.orders.where(checked_out: true)
    end

    def display_past_orders
      placed_orders = self.orders.select {|order| order.checked_out == true}
      order_contents = placed_orders.map{|order| order.roasts}
      # roast_instances_first=roast_instances[0]
      # roast_instances_second=roast_instances[1]
      # combined_array=roast_instances_first.concat(roast_instances_second)
      
      # if order_contents.size == 1
        order_contents.each do |roast|
        roast.each do |item|
        puts "ID:#{item.id}) #{item.name} $#{item.price}"
        end
      end
      #     puts "ID:#{roast.ids}) #{roast.first.name}"
      #   end
      # else
      #   order_contents.each do |roast|
      #     puts "ID:#{roast.ids}) #{roast.name}"
      #   end
      # end
        # binding.pry
        # else
        #   combined_array.each do |roast|
        #   puts "ID:#{roast.ids}) #{roast.first.name}"
        #   end
        # end
      
    end   
  
    def my_cart
      self.orders.find_or_create_by(checked_out: false)
    end

    def display_cart
      self.my_cart.coffee_orders.each do |coffee_order|
        puts "ID:#{coffee_order.id}) #{coffee_order.roast.name}"
      end
    end

    def add_to_cart(roast_inst)
      CoffeeOrder.create(order: self.my_cart, roast: roast_inst)
    end

    def delete_from_cart(coffee_order_id)
      CoffeeOrder.destroy(coffee_order_id)
    end

    def empty_cart(order_inst)
      id = order_inst.id
      Order.destroy(id)
    end

    def place_order
      puts "You're all checked out!"
      self.my_cart.update(checked_out: true)
    end
end