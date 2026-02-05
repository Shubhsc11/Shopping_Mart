class CartItem < ApplicationRecord
	belongs_to :cart, foreign_key: :cart_id
	belongs_to :product, foreign_key: :product_id
	belongs_to :order, foreign_key: :order_id
end
