class Roast < ActiveRecord::Base
  has_many :reviews
  has_many :coffee_orders
  has_many :orders, through: :coffee_orders

  def average_rating
    roast_reviews=reviews.all.select {|review| review.roast_id == self.id}
    ratings_sum=roast_reviews.sum {|review| review.rating}
    average=ratings_sum/roast_reviews.count.to_f
    rounded_ave=average.round(1)
  end

  
end