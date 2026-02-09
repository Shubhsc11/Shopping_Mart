FactoryBot.define do
  factory :order do
    user
    status { 'created' }
  end
end
