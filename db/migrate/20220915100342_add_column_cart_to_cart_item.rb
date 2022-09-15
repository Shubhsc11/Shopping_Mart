class AddColumnCartToCartItem < ActiveRecord::Migration[7.0]
  def change
    add_column :cart_items, :cart_id, :integer
    add_column :cart_items, :product_id, :integer
    add_column :cart_items, :order_id, :integer
  end
end
