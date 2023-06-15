require 'factory_bot'

FactoryBot.define do
  factory :usuario do
    nome { Faker::Name::name }
    email { Faker::Internet::email }
    password { Faker::Internet::password }
  end
end
