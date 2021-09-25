FactoryBot.define do
  factory :user do
    name { 'Antonio' }
    email { 'antonio@mock.com' }
    password { '$eCret123' }
  end

  factory :tony_stark, class: User do
    name { 'Tony Stark' }
    email { 'tony@starkindustries.com' }
    password { 'Aveng3r$' }
  end
end
