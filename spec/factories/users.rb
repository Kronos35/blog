FactoryBot.define do
  factory :user, aliases: %i[antonio] do
    name { 'Antonio' }
    email { 'antonio@mock.com' }
    password { '$eCret123' }
  end

  factory :tony_stark, class: 'User' do
    name { 'Tony Stark' }
    email { 'tony@starkindustries.com' }
    password { 'Aveng3r$' }
  end

  factory :steve_rogers, class: 'User' do
    name { 'Steve Rogers' }
    email { 'steve@avengers.com' }
    password { 'Aveng3r$' }
  end

  factory :bruce_banner, class: 'User' do
    name { 'Bruce Banner' }
    email { 'bruce@avengers.com' }
    password { 'Aveng3r$' }
  end
end
