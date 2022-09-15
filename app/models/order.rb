class Order < ApplicationRecord
	has_many :order_items, dependent: :destroy
	has_many :products, through: :order_items

	enum status: [:created, :confirmed, :shipped, :delivered]

	after_initialize :set_default_status, :if => :new_record?

  def set_default_status
    self.status ||= 'created'
  end

	def sub_total
    sum = 0
    self.order_items.each do |order_item|
      sum+= order_item.total_price
    end
    return sum
  end

end
