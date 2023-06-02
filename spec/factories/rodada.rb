require 'factory_bot'

FactoryBot.define do
  factory :rodada do
    nome { Faker::Name.neutral_first_name }
    ativo { true }
    campeonato { create(:campeonato) }

    factory :rodada_inativa do
      ativo { false }
    end
  end
end
