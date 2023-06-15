class Campeonato < ApplicationRecord
  validates :nome, presence: true, uniqueness: true
  has_many :rodadas
  has_many :competicoes
  has_many :competidores, through: :competicoes, source: :usuario

  scope :ativos, -> { where ativo: true }

  def to_s
    nome
  end

  def ranking
    competidores.map do |competidor|
      {
        id: competidor.id,
        nome: competidor.nome,
        pontuacao: competidor.pontuacao(self)
      }
    end.sort_by { |competidor| competidor[:pontuacao] }.reverse
  end
end
