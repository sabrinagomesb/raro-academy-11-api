class Rodada < ApplicationRecord
  validates :nome, presence: true
  belongs_to :campeonato
  has_many :jogos
end
