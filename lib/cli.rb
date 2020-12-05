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
            menu.choice "Light Roast", -> {view_light}
            menu.choice "Medium Roast", -> {view_medium}
            menu.choice "Dark Roast", -> {view_dark}
            menu.choice "Special Roast", -> {view_special}
            menu.choice "Go Back", -> {main_menu}
        end
    end

    def view_light #maybe try & consolodate all view & purchase helpers?
        system "clear"
        prompt.select("This is our Light Roast Coffee, $10.  What would you like to do next?") do |menu|
            menu.choice "Add to cart.", -> {purchase_light}
            menu.choice "Go back to coffee selections.", -> {see_the_coffee}
        end
    end

    def purchase_light
        system "clear"
        user.add_to_cart(Roast.first)
        puts "Light Roast has been added to your cart!"
        sleep 3
        main_menu
    end

    def view_medium
        system "clear"
        prompt.select("This is our Medium Roast Coffee, $10.  What would you like to do next?") do |menu|
            menu.choice "Add to cart.", -> {purchase_medium}
            menu.choice "Go back to coffee selections.", -> {see_the_coffee}
        end
    end

    def purchase_medium
        system "clear"
        user.add_to_cart(Roast.second)
        puts "Medium Roast has been added to your cart!"
        sleep 3
        main_menu
    end

    def view_dark
        system "clear"
        prompt.select("This is our Dark Roast Coffee, $10.  What would you like to do next?") do |menu|
            menu.choice "Add to cart.", -> {purchase_dark}
            menu.choice "Go back to coffee selections.", -> {see_the_coffee}
        end
    end

    def purchase_dark
        system "clear"
        user.add_to_cart(Roast.third)
        puts "Dark Roast has been added to your cart!"
        sleep 3
        main_menu
    end

    def view_special
        system "clear"
        prompt.select("This is our Special Roast Coffee, $20.  What would you like to do next?") do |menu|
            menu.choice "Add to cart.", -> {purchase_special}
            menu.choice "Go back to coffee selections.", -> {see_the_coffee}
        end
    end

    def purchase_special
        system "clear"
        user.add_to_cart(Roast.fourth)
        puts "Special Roast has been added to your cart!"
        sleep 3
        main_menu
    end
#############################
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

    def bye_bye
        system "clear"
        puts "Thanks for checking us out!  Hope to see you soon :)"
    end
end