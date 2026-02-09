FactoryBot.define do
  factory :order_item do
    order
    product
    item_name { product.p_name }
    item_price { product.p_price }
    item_qty { 1 }
  end
end
