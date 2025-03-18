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

ActiveRecord::Schema[8.0].define(version: 2025_03_18_082659) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "combos", force: :cascade do |t|
    t.bigint "service_id", null: false
    t.integer "count", null: false
    t.decimal "discount", precision: 5, scale: 2, default: "0.0", null: false
    t.decimal "total_price", precision: 10, scale: 2, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_combos_on_service_id"
    t.index ["user_id"], name: "index_combos_on_user_id"
  end

  create_table "customer_combs", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "combo_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["combo_id"], name: "index_customer_combs_on_combo_id"
    t.index ["customer_id"], name: "index_customer_combs_on_customer_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "phone_no", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["phone_no"], name: "index_customers_on_phone_no", unique: true
  end

  create_table "redeems", force: :cascade do |t|
    t.bigint "customer_comb_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_comb_id"], name: "index_redeems_on_customer_comb_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "combos", "services"
  add_foreign_key "combos", "users"
  add_foreign_key "customer_combs", "combos"
  add_foreign_key "customer_combs", "customers"
  add_foreign_key "redeems", "customer_combs"
end
