class Palpite < ApplicationRecord
  validates :gols_mandante, presence: true
  validates :gols_visitante, presence: true
  
  belongs_to :jogo
  belongs_to :usuario
end
