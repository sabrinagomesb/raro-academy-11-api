require 'factory_bot'

FactoryBot.define do
  factory :competicao do
    usuario { create(:usuario) }
    campeonato { create(:campeonato) }
  end
end
