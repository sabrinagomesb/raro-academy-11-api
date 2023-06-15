class Jogo < ApplicationRecord
  belongs_to :mandante, class_name: 'Equipe'
  belongs_to :visitante, class_name: 'Equipe'
  belongs_to :rodada
  has_many :palpites

  before_save :atualiza_pontuacoes

  attr_accessor :palpite

  def pontuacao_palpite
    palpite = Palpite.do_usuario(current_usuario.id).da_rodada(rodada_id).find_by(jogo_id: id)
    return palpite&.pontuacao
  end

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

  def atualiza_pontuacoes
    palpites.each do |palpite|
      palpite.save
    end
  end
end
