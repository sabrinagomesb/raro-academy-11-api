class AddNomeToUsuarios < ActiveRecord::Migration[7.0]
  def change
    add_column :usuarios, :nome, :string
  end
end
