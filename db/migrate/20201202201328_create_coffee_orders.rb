class CreateCoffeeOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :coffee_orders do |t|
      t.integer :roast_id
      t.integer :order_id
    end
  end
end
