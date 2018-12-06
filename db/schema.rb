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

ActiveRecord::Schema.define(version: 2018_12_06_141449) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
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

  create_table "equipements", force: :cascade do |t|
    t.string "nom"
    t.string "marque"
    t.string "modele"
    t.string "snmpcontact"
    t.string "dns"
    t.string "iosv"
    t.string "ip"
    t.date "achat"
    t.integer "garantie"
    t.string "asapid"
    t.string "serial"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "supervision"
    t.integer "sla"
    t.boolean "maintenance"
    t.float "coutmaintenance"
    t.date "datemaintenance"
    t.bigint "projet_id"
    t.boolean "telephonie"
    t.float "honoraire"
  end

  create_table "equipements_incidents", id: false, force: :cascade do |t|
    t.bigint "incident_id", null: false
    t.bigint "equipement_id", null: false
  end

  create_table "incidents", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "debut"
    t.datetime "fin"
    t.string "idnxo"
    t.string "idasap"
    t.text "commentaire"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_incidents_on_user_id"
  end

  create_table "lignes", force: :cascade do |t|
    t.string "numerocompte"
    t.string "ndi"
    t.float "debit"
    t.string "ippublique"
    t.string "mail"
    t.string "tel"
    t.string "identifiantoperateur"
    t.string "mdpoperateur"
    t.string "compte"
    t.string "motdepasse"
    t.bigint "operateur_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "techno"
    t.string "vlan"
    t.float "cout"
    t.index ["operateur_id"], name: "index_lignes_on_operateur_id"
  end

  create_table "localisations", force: :cascade do |t|
    t.string "nom"
    t.string "adresse"
    t.integer "codepostal"
    t.string "ville"
    t.integer "etage"
    t.string "tel"
    t.string "mail"
    t.text "description"
    t.float "lat"
    t.float "lng"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "horaires"
    t.bigint "bp"
    t.string "rattachement"
  end

  create_table "operateurs", force: :cascade do |t|
    t.string "nom"
    t.string "hotline"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id"
  end

  create_table "projets", force: :cascade do |t|
    t.bigint "user_id"
    t.string "titre"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.index ["user_id"], name: "index_projets_on_user_id"
  end

  create_table "recettes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "equipement_id"
    t.bigint "ligne_id"
    t.bigint "localisation_id"
    t.boolean "snmp"
    t.boolean "tacacs"
    t.boolean "testdebit"
    t.boolean "supervision"
    t.boolean "etiquette"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipement_id"], name: "index_recettes_on_equipement_id"
    t.index ["ligne_id"], name: "index_recettes_on_ligne_id"
    t.index ["localisation_id"], name: "index_recettes_on_localisation_id"
    t.index ["user_id"], name: "index_recettes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "incidents", "users"
  add_foreign_key "lignes", "operateurs"
  add_foreign_key "projets", "users"
  add_foreign_key "recettes", "equipements"
  add_foreign_key "recettes", "lignes"
  add_foreign_key "recettes", "localisations"
  add_foreign_key "recettes", "users"
end
