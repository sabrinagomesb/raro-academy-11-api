class Palpite < ApplicationRecord
  validates :gols_mandante, presence: true
  validates :gols_visitante, presence: true

  belongs_to :jogo
  belongs_to :usuario

  scope :do_usuario, -> (usuario_id) { where usuario_id: usuario_id }
  scope :da_rodada, -> (rodada_id) { where jogo_id: Jogo.where(rodada_id: rodada_id).pluck(:id) }

  before_save :set_pontuacao

  def empate?
    gols_mandante == gols_visitante
  end

  def vitoria_mandante?
    gols_mandante > gols_visitante
  end

  def vitoria_visitante?
    gols_mandante < gols_visitante
  end

  def acertou_gols_mandante?
    gols_mandante == jogo.gols_mandante
  end

  def acertou_gols_visitante?
    gols_visitante == jogo.gols_visitante
  end

  def resultado_em_pontos
    resultado = 0
    acertou_gols = acertou_gols_mandante? && acertou_gols_visitante?

    if jogo.empate?
      resultado += 3 if empate?
      resultado += 3 if acertou_gols
    elsif jogo.vitoria_mandante?
      resultado += 3 if vitoria_mandante?
      resultado += 3 if acertou_gols
    elsif jogo.vitoria_visitante?
      resultado += 3 if vitoria_visitante?
      resultado += 3 if acertou_gols
    end

    resultado
  end

  private

  def set_pontuacao
    self.pontuacao = resultado_em_pontos
  end
end
