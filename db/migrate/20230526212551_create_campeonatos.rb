class CreateCampeonatos < ActiveRecord::Migration[7.0]
  def change
    create_table :campeonatos do |t|
      t.string :nome
      t.boolean :ativo

      t.timestamps
    end
  end
end
