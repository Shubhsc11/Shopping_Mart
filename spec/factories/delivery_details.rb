# frozen_string_literal: true

FactoryBot.define do
  factory :delivery_detail do
    order
    user { order.user }
    full_name { Faker::Name.name }
    address { Faker::Address.full_address }
    contact_no { rand(1_000_000_000..2_147_483_647) }
  end
end
