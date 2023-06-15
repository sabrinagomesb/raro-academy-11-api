class Jogo < ApplicationRecord
  belongs_to :mandante, class_name: 'Equipe'
  belongs_to :visitante, class_name: 'Equipe'
  belongs_to :rodada
  has_many :palpites

  attr_accessor :palpite

  def nome
    "#{mandante.nome} x #{visitante.nome}"
  end

  def empate?
    gols_mandante == gols_visitante
  end

  def vitoria_mandante?
    gols_mandante > gols_visitante
  end

  def vitoria_visitante?
    gols_mandante < gols_visitante
  end

end
