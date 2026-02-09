FactoryBot.define do
  factory :category do
    category_name { Faker::Commerce.unique.department }
  end
end
