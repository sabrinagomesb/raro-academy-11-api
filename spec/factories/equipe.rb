require 'factory_bot'

FactoryBot.define do
  factory :equipe do
    nome { Faker::Team.name }
  end
end
