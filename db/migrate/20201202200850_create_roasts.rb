class CreateRoasts < ActiveRecord::Migration[5.2]
  def change
    create_table :roasts do |t|
      t.string :name
      t.integer :price
    end
  end
end