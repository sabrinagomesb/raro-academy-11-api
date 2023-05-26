class Rodada < ApplicationRecord
  validates :nome, presence: true
  belongs_to :campeonato
end
