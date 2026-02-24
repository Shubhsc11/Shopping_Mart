# frozen_string_literal: true

class Cart < ApplicationRecord
  belongs_to :user, class_name: 'User'
  has_many :cart_items, class_name: 'CartItem', dependent: :destroy
  has_many :products, through: :cart_items

  def total_price
    sum = 0
    cart_items.each do |cart_item|
      sum += cart_item.total_price
    end
    sum
  end
end
