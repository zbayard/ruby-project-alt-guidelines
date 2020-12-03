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
            menu.choice "Exit Store.", -> {bye_bye}
        end
    end

    def see_the_coffee
        system "clear"

        prompt.select("Here are our coffee roasts, which one would you like?") do |menu|
            menu.choice "Light Roast", -> {view_light}
            # menu.choice "Medium Roast", ->
            # menu.choice "Dark Roast", ->
            # menu.choice "Special Roast", ->
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

    def see_my_cart
        user.display_cart
        sleep 3
        main_menu
        
    end

    # come back to this
    def past_orders_helper
        user.reload
        puts "Here are your past orders."
        user.display_past_orders
    end

    def check_it_out
        user.place_order
        sleep 3
        main_menu
    end

    def bye_bye
        puts "Thanks for checking us out!  Hope to see you soon :)"
    end












    # def view_menu #returns an array of two separate arrays, is this what we want? this might belong in cli.rb
    #     Roast.all.map{|roast| [roast.name, roast.price]}
    # end

end