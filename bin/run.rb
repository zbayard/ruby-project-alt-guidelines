require_relative '../config/environment'

cli = Cli.new
cli.greet

valid_login = cli.login_or_register

until valid_login
    system "clear"
    valid_login = cli.login_or_register
end

cli.user = valid_login