class Palpite < ApplicationRecord
  validates :gols_mandante, presence: true
  validates :gols_visitante, presence: true

  belongs_to :jogo
  belongs_to :usuario

  scope :do_usuario, -> usuario_id { where usuario_id: usuario_id }
  scope :da_rodada, -> (rodada_id) { where jogo_id: Jogo.where(rodada_id: rodada_id).pluck(:id) }

  def empate?
    gols_mandante == gols_visitante
  end

  def vitoria_mandante?
    gols_mandante > gols_visitante
  end

  def vitoria_visitante?
    gols_mandante < gols_visitante
  end

  def acertou_gols_mandante?(jogo)
    gols_mandante == jogo.gols_mandante
  end

  def acertou_gols_visitante?(jogo)
    gols_visitante == jogo.gols_visitante
  end
end
