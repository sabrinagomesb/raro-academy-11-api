class AddApiIdToJogos < ActiveRecord::Migration[7.0]
  def change
    add_column :jogos, :api_id, :integer
  end
end
