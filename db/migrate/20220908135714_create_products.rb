class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :p_name
      t.integer :p_price
      t.integer :p_qty

      t.timestamps
    end
  end
end
