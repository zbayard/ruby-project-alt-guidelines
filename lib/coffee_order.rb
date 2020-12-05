class CoffeeOrder < ActiveRecord::Base

    belongs_to :roast
    belongs_to :order
  
end