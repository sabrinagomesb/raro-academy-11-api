class Campeonato < ApplicationRecord
  validates :nome, presence: true, uniqueness: true
  has_many :rodadas
  has_many :competicoes
  has_many :competidores, through: :competicoes, source: :usuario

  scope :ativos, -> { where ativo: true }

  def to_s
    nome
  end
end
