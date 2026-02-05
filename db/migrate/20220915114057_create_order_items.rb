class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.string :item_name
      t.integer :item_price
      t.integer :item_qty
      t.integer :product_id
      t.integer :order_id

      t.timestamps
    end
  end
end
