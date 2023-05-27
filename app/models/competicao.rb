class Competicao < ApplicationRecord
  belongs_to :usuario
  belongs_to :campeonato
end
