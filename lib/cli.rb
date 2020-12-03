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

        prompt.select("Welcome, #{user.username}!  What would you like to see next?") do |menu|
            menu.choice "View our coffee." -> 
            menu.choice "View current cart." -> 
            menu.choice "View past orders." -> 
            menu.choice "Check out!" -> 
        end
    end








    # def view_menu #returns an array of two separate arrays, is this what we want? this might belong in cli.rb
    #     Roast.all.map{|roast| [roast.name, roast.price]}
    # end

end