class AddAtivoToJogos < ActiveRecord::Migration[7.0]
  def change
    add_column :jogos, :ativo, :boolean
  end
end
