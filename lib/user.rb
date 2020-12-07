
class User < ActiveRecord::Base
    has_many :orders
    has_many :reviews

    @@prompt = TTY::Prompt.new


    def self.login_user
      puts "Enter your username."
      userName = gets.chomp
      puts "Thanks #{userName}!- Enter your password."
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
      
      order_contents.each do |roast|
        roast.each do |item|
        puts "ID:#{item.id}) #{item.name} $#{item.price}"
        end
      end
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

    def empty_cart(order_inst)
      id = order_inst.id
      Order.destroy(id)
    end

    def place_order
      puts "You're all checked out!"
      self.my_cart.update(checked_out: true)
    end

    def write_review
      puts "Please rate this roast 1-5."
      rating = gets.chomp.to_i
    
      roast_id1 = self.reviews.pluck(:roast_id)
      roast_id2 = roast_id1.last
      Review.create(user_id: self.id, roast_id: roast_id2, rating: rating)
      
    end
end