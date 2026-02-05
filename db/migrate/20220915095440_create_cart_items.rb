class CreateCartItems < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items do |t|
      t.string :item_name
      t.integer :item_price
      t.integer :item_qty

      t.timestamps
    end
  end
end
