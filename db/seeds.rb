Roast.destroy_all
User.destroy_all
Order.destroy_all
CoffeeOrder.destroy_all

# USERS
zach = User.create(username: "Zach", password: "hello")
claire = User.create(username: "Claire", password: "abc123")

#ROASTS
light = Roast.create(name: "Light", price: 10)
medium = Roast.create(name: "Medium", price: 10)
dark = Roast.create(name: "Dark", price: 10)
special = Roast.create(name: "Special", price: 20)

#REVIEWS
review1=Review.create(user_id: 2, roast_id: 1, rating: 4)
review2=Review.create(user_id: 2, roast_id: 2, rating: 4)
review3=Review.create(user_id: 2, roast_id: 3, rating: 4)
review4 =Review.create(user_id: 2, roast_id: 4, rating: 4)
review5 = Review.create(user_id: 1, roast_id: 1, rating: 5)
review6 = Review.create(user_id: 1, roast_id: 2, rating: 5)
review7 = Review.create(user_id: 1, roast_id: 3, rating: 5)
review8 = Review.create(user_id: 1, roast_id: 4, rating: 5)


