FactoryBot.define do
  factory :product do
    p_name { Faker::Commerce.unique.product_name }
    p_price { Faker::Commerce.price(range: 10..100) }
    p_qty { Faker::Number.between(from: 1, to: 100) }
    user
    category
    subcategory
  end
end
