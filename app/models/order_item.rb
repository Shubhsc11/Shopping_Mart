# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  def total_price
    item_qty * product.p_price
  end
end
