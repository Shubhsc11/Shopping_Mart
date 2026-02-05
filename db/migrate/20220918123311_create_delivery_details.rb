class CreateDeliveryDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :delivery_details do |t|
      t.string :full_name
      t.text :address
      t.integer :contact_no
      t.integer :order_id
      t.integer :user_id

      t.timestamps
    end
  end
end
