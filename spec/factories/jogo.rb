require 'factory_bot'

FactoryBot.define do
  factory :jogo do
    mandante { create(:equipe) }
    visitante { create(:equipe) }
    rodada { create(:rodada) }
    gols_mandante { Faker::Number.between from: 1, to: 10 }
    gols_visitante { Faker::Number.between from: 1, to: 10 }
    data_hora { Faker::Date.forward }
  end
end
