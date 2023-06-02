require 'factory_bot'

FactoryBot.define do
  factory :campeonato do
    nome { Faker::Name.neutral_first_name }
    ativo { true }

    factory :campeonato_inativo do
      ativo { false }
    end
  end
end
