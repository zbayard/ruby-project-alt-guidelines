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
      self.past_orders.orders.each do |order|
        puts "ID:#{order.id}"
      end
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