class Roast < ActiveRecord::Base
  has_many :reviews
  has_many :coffee_orders
  has_many :orders, through: :coffee_orders
  
end