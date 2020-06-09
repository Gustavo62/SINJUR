# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_09_145650) do

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body", limit: 16777215
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "cadastro_atendimento_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cadastro_atendimento_id"], name: "index_action_text_rich_texts_on_cadastro_atendimento_id"
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "advogados", force: :cascade do |t|
    t.string "nome"
    t.string "endereço"
    t.string "cidade"
    t.string "bairro"
    t.string "cep"
    t.string "telefone"
    t.string "email"
    t.string "advogado"
    t.string "oab"
    t.string "observação"
    t.integer "cadastro_atendimento_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cadastro_atendimento_id"], name: "index_advogados_on_cadastro_atendimento_id"
  end

  create_table "cadastro_atendimentos", force: :cascade do |t|
    t.integer "codigo_tj_filiado"
    t.text "texto_livre"
    t.text "editor1"
    t.string "nome"
    t.integer "cpf"
    t.integer "telefone"
    t.string "status"
    t.date "data_atendimento"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contatos", force: :cascade do |t|
    t.string "nome"
    t.string "profissao"
    t.string "detalhe"
    t.string "logradouro"
    t.string "bairro"
    t.string "cidade"
    t.string "observacao"
    t.string "dn"
    t.string "email"
    t.string "site"
    t.string "cep"
    t.string "numero"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "filiados", force: :cascade do |t|
    t.integer "cnpj"
    t.integer "cei"
    t.integer "codigo_tj"
    t.integer "codigo_cnpj"
    t.integer "cep"
    t.integer "numero_casa"
    t.integer "telefone_fixo_casa"
    t.string "nome_contato"
    t.string "logradouro"
    t.string "complemento"
    t.string "bairro"
    t.string "cidade_integer"
    t.string "email"
    t.integer "cadastro_atendimento_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cadastro_atendimento_id"], name: "index_filiados_on_cadastro_atendimento_id"
  end

  create_table "pessoas", force: :cascade do |t|
    t.string "nome"
    t.string "profissao"
    t.string "cep"
    t.string "razao_social"
    t.string "nome_fantasia"
    t.string "cidade"
    t.string "endereço"
    t.string "cpf"
    t.integer "rg"
    t.integer "pis"
    t.integer "residencial"
    t.integer "comercial"
    t.integer "celular"
    t.string "nacionalidade"
    t.string "estado_civil"
    t.string "bairro"
    t.string "email"
    t.string "escolaridade"
    t.string "insc_estadual"
    t.string "insc_municipal"
    t.string "responsável"
    t.string "cnpj"
    t.integer "cadastro_atendimento_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cadastro_atendimento_id"], name: "index_pessoas_on_cadastro_atendimento_id"
  end

  create_table "processos", force: :cascade do |t|
    t.string "status_processo"
    t.string "area_atuacao"
    t.string "objeto_acao"
    t.string "assunto"
    t.string "detalhe"
    t.string "pasta"
    t.string "etiqueta"
    t.string "favorito"
    t.string "local_tramite_um"
    t.string "local_tramite_dois"
    t.integer "cadastro_atendimento_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cadastro_atendimento_id"], name: "index_processos_on_cadastro_atendimento_id"
  end

  create_table "restrito_tela_agenda_atividades", force: :cascade do |t|
    t.string "tipo"
    t.string "titulo"
    t.string "nivel"
    t.text "resumo"
    t.date "agendamento"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tabeliaos", force: :cascade do |t|
    t.string "nome"
    t.integer "cpf"
    t.integer "numero"
    t.integer "filiado_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["filiado_id"], name: "index_tabeliaos_on_filiado_id"
  end

  create_table "telefones", force: :cascade do |t|
    t.string "telefone"
    t.integer "contato_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contato_id"], name: "index_telefones_on_contato_id"
  end

end
