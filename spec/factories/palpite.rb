require 'factory_bot'

FactoryBot.define do
  factory :palpite do
    usuario { create(:usuario) }
    jogo { create(:jogo) }
    gols_mandante { Faker::Number.between from: 1, to: 10 }
    gols_visitante { Faker::Number.between from: 1, to: 10 }
  end
end
