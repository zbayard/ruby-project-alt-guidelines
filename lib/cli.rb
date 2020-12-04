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

        prompt.select("Welcome to Brooklyn Roasting CO, #{user.username}!  What would you like to see next?") do |menu|
            menu.choice "View our coffee selection.", -> {see_the_coffee} 
            menu.choice "View current cart.", -> {see_my_cart}
            menu.choice "View past orders.", -> {past_orders_helper}
            menu.choice "Check out!", -> {check_it_out}
            menu.choice "Empty Cart", -> {empty_cart_helper}
            menu.choice "Exit Store.", -> {bye_bye}
        end
    end

    def see_the_coffee
        system "clear"

        prompt.select("Here are our coffee roasts, which one would you like?") do |menu|
            menu.choice "Light Roast", -> {view_light}
            menu.choice "Medium Roast", -> {view_medium}
            menu.choice "Dark Roast", -> {view_dark}
            menu.choice "Special Roast", -> {view_special}
            menu.choice "Go Back", -> {main_menu}
        end
    end

    def view_light
        # Show the coffee instance
        prompt.select("This is our Light Roast Coffee, $10.  What would you like to do next?") do |menu|
            menu.choice "Add to cart.", -> {purchase_light}
            menu.choice "Go back to coffee selections.", -> {see_the_coffee}
        end
    end

    def purchase_light
        user.add_to_cart(Roast.first)
        puts "Light Roast has been added to your cart!"
        sleep 3
        main_menu
    end

    def view_medium
        prompt.select("This is our Medium Roast Coffee, $10.  What would you like to do next?") do |menu|
            menu.choice "Add to cart.", -> {purchase_medium}
            menu.choice "Go back to coffee selections.", -> {see_the_coffee}
        end
    end

    def purchase_medium
        user.add_to_cart(Roast.second)
        puts "Medium Roast has been added to your cart!"
        sleep 3
        main_menu
    end

    def view_dark
        prompt.select("This is our Dark Roast Coffee, $10.  What would you like to do next?") do |menu|
            menu.choice "Add to cart.", -> {purchase_dark}
            menu.choice "Go back to coffee selections.", -> {see_the_coffee}
        end
    end

    def purchase_dark
        user.add_to_cart(Roast.third)
        puts "Dark Roast has been added to your cart!"
        sleep 3
        main_menu
    end

    def view_special
        prompt.select("This is our Special Roast Coffee, $20.  What would you like to do next?") do |menu|
            menu.choice "Add to cart.", -> {purchase_special}
            menu.choice "Go back to coffee selections.", -> {see_the_coffee}
        end
    end

    def purchase_special
        user.add_to_cart(Roast.fourth)
        puts "Special Roast has been added to your cart!"
        sleep 3
        main_menu
    end
#############################
    def see_my_cart #why is else displaying cart when not called? 
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

    # come back to this, return looks messy, we don't have access to roast, combine arrays? 
    def past_orders_helper
        user.reload
        puts "Here are your past orders."
        user.past_orders
    end

    def check_it_out
        user.place_order
        sleep 3
        main_menu
    end

    def empty_cart_helper
        user.empty_cart(user.my_cart)
        puts "Your cart is now empty!"
        sleep 3 
        main_menu
    end

    def bye_bye
        puts "Thanks for checking us out!  Hope to see you soon :)"
    end

    
    #add see_my_total to see_my_cart maybe or add as selection in main menu



    







    

end