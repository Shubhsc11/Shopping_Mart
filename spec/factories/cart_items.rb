# frozen_string_literal: true

FactoryBot.define do
  factory :cart_item do
    cart
    product
    item_qty { 1 }
  end
end
