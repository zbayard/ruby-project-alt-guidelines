class Cli

    attr_reader :prompt
    attr_accessor :user

    def initialize
        @prompt = TTY::Prompt.new
    end
    


    def greet
    puts "Welcome to Brooklyn Roasting CO.  Where we roast the best coffee for you!"
    end

    def login_or_register
        prompt.select("Hello!  Login or Register?") do |menu|
            # menu.choice "Login", -> {CREATE LOGIIN HELPER METHOD}
            # menu.choice "Register", -> {CREATE REGISTER HELPER METHOD}
        end
    end




    def view_menu #returns an array of two separate arrays, is this what we want? this might belong in cli.rb
        Roast.all.map{|roast| [roast.name, roast.price]}
    end

end