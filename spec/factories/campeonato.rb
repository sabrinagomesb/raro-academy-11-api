require 'factory_bot'

FactoryBot.define do
  factory :campeonato do
    nome { Faker::Name.unique.name }
    ativo { true }

    factory :campeonato_inativo do
      ativo { false }
    end
  end
end
