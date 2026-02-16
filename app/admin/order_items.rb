# frozen_string_literal: true

ActiveAdmin.register OrderItem do
  menu parent: 'Order Details', priority: 2
  actions :all, except: %i[new edit destroy]

  filter :id
  filter :item_price
  filter :item_name, as: :select, collection: OrderItem.pluck(:item_name).uniq
  filter :product_id, as: :select, collection: Product.all.map { |p| [p.p_name, p.id] }
  filter :order_id, as: :select, collection: Order.ids

  index do
    selectable_column
    column :id
    column :item_name
    column :item_price
    column :item_qty
    column 'Product Id', :product_id do |product_id|
      product = Product.find_by(id: product_id.product_id)
      product ? link_to(product.p_name, admin_product_path(product.id)) : '-'
    end
    column 'Order Id', :order_id do |order_id|
      order = Order.find_by(id: order_id.order_id)
      order ? link_to(order.id, admin_order_path(order.id)) : '-'
    end

    actions
  end
end
