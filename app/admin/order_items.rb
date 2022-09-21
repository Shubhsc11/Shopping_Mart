ActiveAdmin.register OrderItem do

	actions :all, :except => [:new, :edit, :destroy]

  # filter :id
  # filter :item_name
  # filter :product_id
  # filter :order_id

  # index do
  #   selectable_column
  #   column :id
  #   column :item_name
  #   column :item_price
  #   column :item_qty
  #   column :product_id
  #   column :order_id
    
  #   actions
  # end
  
end
