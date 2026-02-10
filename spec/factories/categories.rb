# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    category_name { Faker::Commerce.unique.department }
  end
end
