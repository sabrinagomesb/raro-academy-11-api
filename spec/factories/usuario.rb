require 'factory_bot'

FactoryBot.define do
  factory :usuario do
    email { Faker::Internet::email }
    password { Faker::Internet::password }
  end
end
