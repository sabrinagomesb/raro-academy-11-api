class AddApiIdToRodada < ActiveRecord::Migration[7.0]
  def change
    add_column :rodadas, :api_id, :integer
  end
end
