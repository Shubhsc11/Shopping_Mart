FactoryBot.define do
  factory :subcategory do
    subcategory_name { Faker::Commerce.unique.department }
    category
  end
end
