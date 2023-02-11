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

ActiveRecord::Schema[7.0].define(version: 2018_10_13_152718) do
  create_table "accounts", force: :cascade do |t|
    t.integer "bank_id"
    t.string "foreign_id"
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "disabled", default: false, null: false
    t.index ["bank_id", "foreign_id"], name: "index_accounts_on_bank_id_and_foreign_id", unique: true
    t.index ["bank_id"], name: "index_accounts_on_bank_id"
  end

  create_table "accounts_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "account_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["account_id"], name: "index_accounts_users_on_account_id"
    t.index ["user_id", "account_id"], name: "index_accounts_users_on_user_id_and_account_id", unique: true
    t.index ["user_id"], name: "index_accounts_users_on_user_id"
  end

  create_table "banks", force: :cascade do |t|
    t.string "name"
    t.string "fine_ants_adapter"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "snapshots", force: :cascade do |t|
    t.integer "account_id"
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "USD", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["account_id"], name: "index_snapshots_on_account_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "bank_id"
    t.string "user"
    t.string "password"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "disabled", default: false, null: false
    t.index ["bank_id"], name: "index_users_on_bank_id"
  end

  create_table "wages", force: :cascade do |t|
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "USD", null: false
    t.date "date"
    t.string "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  add_foreign_key "accounts", "banks"
  add_foreign_key "accounts_users", "accounts"
  add_foreign_key "accounts_users", "users"
  add_foreign_key "snapshots", "accounts"
  add_foreign_key "users", "banks"
end
