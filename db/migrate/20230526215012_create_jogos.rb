class CreateJogos < ActiveRecord::Migration[7.0]
  def change
    create_table :jogos do |t|
      t.references :mandante, null: false
      t.references :visitante, null: false
      t.integer :gols_mandante
      t.integer :gols_visitante
      t.references :rodada, null: false, foreign_key: true
      t.datetime :data_hora

      t.timestamps
    end

    add_foreign_key "jogos", "equipes", column: "mandante_id"
    add_foreign_key "jogos", "equipes", column: "visitante_id"
  end
end