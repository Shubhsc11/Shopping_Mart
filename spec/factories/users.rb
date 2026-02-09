FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { 'password' }
    password_confirmation { 'password' }
    roles { 'customer' }
  end
end
