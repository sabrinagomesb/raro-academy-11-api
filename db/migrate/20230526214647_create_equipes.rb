class CreateEquipes < ActiveRecord::Migration[7.0]
  def change
    create_table :equipes do |t|
      t.string :nome

      t.timestamps
    end
  end
end
