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

ActiveRecord::Schema[7.0].define(version: 2022_12_12_034822) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_admin", default: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.date "birth_date"
    t.boolean "is_handling_report", default: false
    t.integer "dni"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "alquilers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "auto_id"
    t.date "fecha_alquiler"
    t.time "hora_alquiler"
    t.date "fecha_devolucion"
    t.time "hora_devolucion"
    t.decimal "precio_total"
    t.time "duracion"
    t.date "fecha_user_devolucion"
    t.time "hora_user_devolucion"
    t.integer "duracion_en_cant_horas"
    t.time "tiempo_de_demora"
    t.float "precio_por_demora"
    t.float "precio_de_reserva"
    t.index ["auto_id"], name: "index_alquilers_on_auto_id"
    t.index ["user_id"], name: "index_alquilers_on_user_id"
  end

  create_table "autos", force: :cascade do |t|
    t.string "patente"
    t.float "porcentaje_combustible"
    t.string "estado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "modelo"
    t.integer "anio"
    t.string "tipo_de_caja"
    t.string "tipo_de_combustible"
    t.string "color"
    t.point "location_point"
    t.bigint "alquiler_id"
    t.boolean "is_open"
    t.index ["alquiler_id"], name: "index_autos_on_alquiler_id"
  end

  create_table "cards", force: :cascade do |t|
    t.string "cvv"
    t.bigint "number"
    t.string "date"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "brand"
  end

  create_table "perros", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "precios", force: :cascade do |t|
    t.float "valor"
    t.datetime "fecha_de_actualizacion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reportes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "alquiler_id"
    t.string "descripcion"
    t.integer "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tipo", default: 0
    t.string "title"
    t.integer "auto_id"
    t.integer "status", default: 0
    t.index ["status"], name: "index_reportes_on_status"
    t.index ["tipo"], name: "index_reportes_on_tipo"
  end

  create_table "supervisors", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_supervisors_on_email", unique: true
    t.index ["reset_password_token"], name: "index_supervisors_on_reset_password_token", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.date "birth_date"
    t.date "license_valid_until"
    t.integer "status", default: 1
    t.boolean "is_renting", default: false
    t.bigint "alquiler_id"
    t.index ["alquiler_id"], name: "index_users_on_alquiler_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wallets", force: :cascade do |t|
    t.float "saldo"
    t.float "ultimo_gasto"
    t.float "ultima_carga"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "alquilers", "autos"
  add_foreign_key "alquilers", "users"
  add_foreign_key "autos", "alquilers"
  add_foreign_key "users", "alquilers"
end
