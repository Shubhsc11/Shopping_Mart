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
    order_items.sum(&:total_price)
  end

  def refundable?
    shipped? || delivered?
  end

  def cancel!
    ActiveRecord::Base.transaction do
      user.update!(points: user.points + sub_total)
      order_items.each do |item|
        item.product.update!(p_qty: item.product.p_qty + item.item_qty)
      end
      update!(status: 'cancelled')
    end
  end

  def place!(delivery_detail_id)
    ActiveRecord::Base.transaction do
      update!(status: 'placed', delivery_detail_id: delivery_detail_id)
      user.update!(points: user.points - sub_total)
      order_items.each do |item|
        product = item.product
        product.update!(p_qty: product.p_qty - item.item_qty)
      end
    end
  end
end
