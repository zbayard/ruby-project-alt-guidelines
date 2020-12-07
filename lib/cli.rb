class Cli

    attr_reader :prompt
    attr_accessor :user

    def initialize
        @prompt = TTY::Prompt.new
    end
    
    def greet
        puts "Welcome to Brooklyn Roasting CO. Where we roast the best coffee for you!"
    end

    def login_or_register
        prompt.select("Hello!  Login or Register?") do |menu|
            menu.choice "Login", -> {login_helper}
            menu.choice "Register", -> {register_helper}
        end
    end

    def login_helper
        User.login_user
    end

    def register_helper
        User.register_user
    end

    def main_menu
        user.reload
        system "clear"

        prompt.select("Welcome to Brooklyn Roasting Co, #{user.username}!  What would you like to see next?") do |menu|
            menu.choice "View our coffee selection.", -> {see_the_coffee} 
            menu.choice "View current cart.", -> {see_my_cart}
            menu.choice "View past orders.", -> {past_orders_helper}
            menu.choice "View current total.", -> {view_current_total}
            menu.choice "Check out!", -> {check_it_out}
            menu.choice "Empty cart.", -> {empty_cart_helper}
            menu.choice "Exit store.", -> {bye_bye}
        end
    end

    def see_the_coffee
        system "clear"

      prompt.select("Here are our coffee roasts, which one would you like?") do |menu|
        menu.choice "Light Roast", -> {view_roast("Light")}
        menu.choice "Medium Roast", -> {view_roast("Medium")}
        menu.choice "Dark Roast", -> {view_roast("Dark")}
        menu.choice "Special Roast", -> {view_roast("Special")}
        menu.choice "Go Back", -> {main_menu}
      end
    end

    def view_roast(roast_name)
      system "clear"
      roast_inst=Roast.find_by(name: roast_name)
      prompt.select("This is our #{roast_name} Roast Coffee, $#{roast_inst.price}. It has an average rating of #{roast_inst.average_rating}. What would you like to do next?") do |menu|
        menu.choice "Add to cart.", -> {purchase_roast(roast_name)}
        menu.choice "Go back to coffee selections.", -> {see_the_coffee}
        menu.choice "Leave a roast review", -> {write_review_helper(roast_inst)}
      end
    end

    def purchase_roast(roast_name)
      system "clear"
      roast_inst=Roast.find_by(name: roast_name)
      user.add_to_cart(roast_inst)
      puts "#{roast_name} Roast has been added to your cart!"
      sleep 3
      main_menu
    end

    def see_my_cart
        system "clear"
        puts "Current Cart:"
        if user.display_cart == []
            puts "Your cart is empty!"
            sleep 3
            main_menu
        else
            sleep 3
            main_menu
        end  
    end
 
    def past_orders_helper
        system "clear"
        user.reload
        puts "Here are your past orders."
        user.display_past_orders
        sleep 3
        main_menu
    end

    def view_current_total
        system "clear"
        puts "Your total is $#{user.my_cart.view_total}"
        sleep 3
        main_menu
    end

    def check_it_out
        system "clear"
        if user.display_cart == []
            puts "You have nothing in your cart!"
        else
            user.place_order
        end
        sleep 3
        main_menu
    end

    def empty_cart_helper
        system "clear"
        user.empty_cart(user.my_cart)
        puts "Your cart is now empty!"
        sleep 3 
        main_menu
    end

    def write_review_helper(roast_inst)
        system "clear"
        user.write_review(roast_inst)

        puts "Thanks for leaving a review!"
        sleep 5
        main_menu

    end

    def bye_bye
        system "clear"
        puts "Thanks for checking us out!  Hope to see you soon :)"
        sleep 5
        system "clear"
    end
end