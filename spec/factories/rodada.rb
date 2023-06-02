require 'factory_bot'

FactoryBot.define do
  factory :rodada do
    nome { 'Campeonato Brasileiro 2023' }
    ativo { true }
    campeonato { create(:campeonato) }

    factory :rodada_inativa do
      ativo { false }
    end
  end
end
