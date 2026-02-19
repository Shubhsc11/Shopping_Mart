# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user, class_name: 'User'
  has_many :order_items, class_name: 'OrderItem', dependent: :destroy
  has_many :products, through: :order_items, class_name: 'Product'
  belongs_to :delivery_detail, class_name: 'DeliveryDetail', optional: true

  enum :status, { draft: 'draft', placed: 'placed', confirmed: 'confirmed', shipped: 'shipped',
                  delivered: 'delivered', cancelled: 'cancelled' }

  after_initialize :set_default_status, if: :new_record?

  def set_default_status
    self.status ||= 'draft'
  end

  def sub_total
    sum = 0
    order_items.each do |order_item|
      sum += order_item.total_price
    end
    sum
  end
end
