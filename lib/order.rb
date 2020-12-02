class Order < ActiveRecord::Base
    belongs_to :user

    has_many :coffee_orders
    has_many :roasts, through: :coffee_orders

end
