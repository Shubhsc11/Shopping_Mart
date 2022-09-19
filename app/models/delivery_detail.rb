class DeliveryDetail < ApplicationRecord
	belongs_to :order, class_name: 'Order', foreign_key: :order_id
	belongs_to :user, class_name: 'User', foreign_key: :user_id
end
