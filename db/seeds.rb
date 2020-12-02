Roast.destroy_all
User.destroy_all
Order.destroy_all
CoffeeOrder.destroy_all

# USERS
zach = User.create(username: "Zach", password: "hello")
claire = User.create(username: "Claire", password: "abc123")
jack = User.create(username: "Jack", password: "456")

#ORDERS
order1 = Order.create(user_id: zach.id, checked_out: false)
order2 = Order.create(user_id: claire.id, checked_out: false)
order3 = Order.create(user_id: jack.id, checked_out: false)

#ROASTS
light = Roast.create(name: "Light", price: 10)
medium = Roast.create(name: "Medium", price: 10)
dark = Roast.create(name: "Dark", price: 10)
special = Roast.create(name: "Special", price: 20)

#COFFEE_ORDERS
coffeeorder1 = CoffeeOrder.create(roast_id: light.id, order_id: order1.id)
coffeeorder2 = CoffeeOrder.create(roast_id: medium.id, order_id: order2.id)
coffeeorder3 = CoffeeOrder.create(roast_id: dark.id, order_id: order3.id)