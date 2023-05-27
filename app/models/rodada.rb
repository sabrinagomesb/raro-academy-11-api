class Rodada < ApplicationRecord
  validates :nome, presence: true
  belongs_to :campeonato
  has_many :jogos

  accepts_nested_attributes_for :jogos, allow_destroy: true, reject_if: :all_blank
end
