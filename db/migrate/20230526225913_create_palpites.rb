class CreatePalpites < ActiveRecord::Migration[7.0]
  def change
    create_table :palpites do |t|
      t.references :jogo, null: false, foreign_key: true
      t.references :usuario, null: false, foreign_key: true
      t.integer :gols_mandante
      t.integer :gols_visitante

      t.timestamps
    end
  end
end
