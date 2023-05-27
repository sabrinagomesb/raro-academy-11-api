class CreateCompeticoes < ActiveRecord::Migration[7.0]
  def change
    create_table :competicoes do |t|
      t.references :usuario, null: false, foreign_key: true
      t.references :campeonato, null: false, foreign_key: true

      t.timestamps
    end
  end
end
