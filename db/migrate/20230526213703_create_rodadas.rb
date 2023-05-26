class CreateRodadas < ActiveRecord::Migration[7.0]
  def change
    create_table :rodadas do |t|
      t.string :nome
      t.boolean :ativo
      t.references :campeonato, null: false, foreign_key: true

      t.timestamps
    end
  end
end
