FactoryBot.define do
  factory :follow do
    association :user, factory: :user
    association :recipient, factory: :tony_stark
  end
end
