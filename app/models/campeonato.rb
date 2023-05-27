class Campeonato < ApplicationRecord
  validates :nome, presence: true, uniqueness: true
  has_many :rodadas

  scope :ativos, -> { where ativo: true }

  def to_s
    nome
  end
end
