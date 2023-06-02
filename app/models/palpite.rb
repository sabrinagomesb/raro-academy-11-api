class Palpite < ApplicationRecord
  validates :gols_mandante, presence: true
  validates :gols_visitante, presence: true

  scope :do_usuario, -> (usuario_id) { where usuario_id: usuario_id }
  scope :da_rodada, -> (rodada_id) { where jogo_id: Jogo.where(rodada_id: rodada_id).pluck(:id) }
  
  belongs_to :jogo
  belongs_to :usuario
end
