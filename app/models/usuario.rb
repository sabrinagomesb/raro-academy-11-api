class Usuario < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  has_many :palpites
  has_many :competicoes
  has_many :campeonatos, through: :competicoes, source: :campeonato

  def to_s
    email
  end
end
