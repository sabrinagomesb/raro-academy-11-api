class AddApiIdToEquipes < ActiveRecord::Migration[7.0]
  def change
    add_column :equipes, :api_id, :integer
  end
end
