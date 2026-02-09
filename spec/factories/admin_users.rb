FactoryBot.define do
  factory :admin_user do
    email { Faker::Internet.unique.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
