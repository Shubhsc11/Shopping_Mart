FactoryBot.define do
  factory :delivery_detail do
    order
    user { order.user }
    full_name { Faker::Name.name }
    address { Faker::Address.full_address }
    contact_no { rand(1000000000..2147483647) }
  end
end
