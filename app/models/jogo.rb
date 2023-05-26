class Jogo < ApplicationRecord
  belongs_to :mandante, class_name: 'Equipe'
  belongs_to :visitante, class_name: 'Equipe'
  belongs_to :rodada
end
