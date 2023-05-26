class Campeonato < ApplicationRecord
  validates :nome, presence: true, uniqueness: true
  has_many :rodadas
end
