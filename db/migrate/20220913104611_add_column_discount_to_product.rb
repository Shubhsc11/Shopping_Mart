class AddColumnDiscountToProduct < ActiveRecord::Migration[7.0]
  def change
    # add_column :products, :discount, :integer
    add_column :products, :user_id, :integer
  end
end
