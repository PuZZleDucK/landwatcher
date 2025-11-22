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

ActiveRecord::Schema[8.1].define(version: 2025_11_22_022916) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "properties", force: :cascade do |t|
    t.integer "bedrooms"
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "price"
    t.integer "property_type"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["bedrooms"], name: "index_properties_on_bedrooms"
    t.index ["description"], name: "index_properties_on_description"
    t.index ["price"], name: "index_properties_on_price"
    t.index ["property_type"], name: "index_properties_on_property_type"
    t.index ["title"], name: "index_properties_on_title"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "watches", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "property_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["property_id"], name: "index_watches_on_property_id"
    t.index ["user_id"], name: "index_watches_on_user_id"
  end

  add_foreign_key "watches", "properties"
  add_foreign_key "watches", "users"
end
