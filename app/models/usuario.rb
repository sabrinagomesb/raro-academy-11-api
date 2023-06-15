class Usuario < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  validates :nome, presence: true

  has_many :palpites
  has_many :competicoes
  has_many :campeonatos, through: :competicoes, source: :campeonato

  def to_s
    email
  end

  def pontuacao(campeonato)
    pontuacao = 0
    campeonato.rodadas.each do |rodada|
      rodada.jogos.each do |jogo|
        palpite = Palpite.find_by(jogo_id: jogo.id, usuario_id: id)
        unless palpite
          pontuacao -= 1
          next
        end
        pontuacao += palpite.pontuacao
      end
    end
    pontuacao
  end
end
