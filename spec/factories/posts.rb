FactoryBot.define do
  factory :post do
    association :user, factory: :user
    body { 'MyText' }
    title { 'MyString' }
  end
end
