class OrderItem < ApplicationRecord
	belongs_to :order, foreign_key: :order_id
	belongs_to :product, foreign_key: :product_id

	def total_price
    self.item_qty * product.p_price
  end

end
