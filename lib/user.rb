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

    def display_past_orders #why can't we use coffee_orders here? 
      placed_orders = self.orders.select {|order| order.checked_out == true}
      #<Order:0x00007f8a9be24370 id: 7, user_id: 12, checked_out: true, created_at: 2020-12-02 22:10:17 UTC, updated_at: 2020-12-03 20:13:41 UTC>
      roast_instances = placed_orders.map{|order| order.roasts}
      roast_instances.each do |roast|
      # binding.pry
        puts "ID:#{roast.ids}) #{roast.name}"
      end
      # roast_instances.map {|instance| instance.name}
      #[[#<Roast:0x00007f8aa0108448 id: 3, name: "Medium", price: 10>, #<Roast:0x00007f8aa0108218 id: 2, name: "Light", price: 10>], [#<Roast:0x00007f8a9bb67bf0 id: 2, name: "Light", price: 10>]]
      # var2 = var.map {|order| order.roasts}
      # var2.select{|roast| roast.name}
    
      # pull the order instances for user that are true(checked out) from those orders display contents aka roast & quantity
        
    
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