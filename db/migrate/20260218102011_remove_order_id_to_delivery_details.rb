class RemoveOrderIdToDeliveryDetails < ActiveRecord::Migration[7.0]
  def change
    remove_column :delivery_details, :order_id
    add_column :orders, :delivery_detail_id, :integer
  end
end
