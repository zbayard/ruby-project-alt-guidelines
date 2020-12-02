class Order < ActiveRecord::Base
    belongs_to :user

    has_many :coffee_orders
    has_many :roasts, through: :coffee_orders

# VIEW TOTAL
# user can see total of prices added to current cart

end
