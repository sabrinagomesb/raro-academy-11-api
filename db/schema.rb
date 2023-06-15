# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_06_15_133158) do
  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "campeonatos", force: :cascade do |t|
    t.string "nome"
    t.boolean "ativo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "api_id"
  end

  create_table "competicoes", force: :cascade do |t|
    t.integer "usuario_id", null: false
    t.integer "campeonato_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campeonato_id"], name: "index_competicoes_on_campeonato_id"
    t.index ["usuario_id"], name: "index_competicoes_on_usuario_id"
  end

  create_table "equipes", force: :cascade do |t|
    t.string "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jogos", force: :cascade do |t|
    t.integer "mandante_id", null: false
    t.integer "visitante_id", null: false
    t.integer "gols_mandante"
    t.integer "gols_visitante"
    t.integer "rodada_id", null: false
    t.datetime "data_hora"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mandante_id"], name: "index_jogos_on_mandante_id"
    t.index ["rodada_id"], name: "index_jogos_on_rodada_id"
    t.index ["visitante_id"], name: "index_jogos_on_visitante_id"
  end

  create_table "palpites", force: :cascade do |t|
    t.integer "jogo_id", null: false
    t.integer "usuario_id", null: false
    t.integer "gols_mandante"
    t.integer "gols_visitante"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pontuacao", default: 0
    t.index ["jogo_id"], name: "index_palpites_on_jogo_id"
    t.index ["usuario_id"], name: "index_palpites_on_usuario_id"
  end

  create_table "rodadas", force: :cascade do |t|
    t.string "nome"
    t.boolean "ativo"
    t.integer "campeonato_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "api_id"
    t.index ["campeonato_id"], name: "index_rodadas_on_campeonato_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin"
    t.string "nome"
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
  end

  add_foreign_key "competicoes", "campeonatos"
  add_foreign_key "competicoes", "usuarios"
  add_foreign_key "jogos", "equipes", column: "mandante_id"
  add_foreign_key "jogos", "equipes", column: "visitante_id"
  add_foreign_key "jogos", "rodadas"
  add_foreign_key "palpites", "jogos"
  add_foreign_key "palpites", "usuarios"
  add_foreign_key "rodadas", "campeonatos"
end
