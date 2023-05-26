class Campeonato < ApplicationRecord
  validates :nome, presence: true, uniqueness: true
end
