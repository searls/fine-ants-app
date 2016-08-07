# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160807025440) do

  create_table "accounts", force: :cascade do |t|
    t.integer  "bank_id"
    t.integer  "user_id"
    t.string   "foreign_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "accounts", ["bank_id"], name: "index_accounts_on_bank_id"
  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id"

  create_table "banks", force: :cascade do |t|
    t.string   "name"
    t.string   "fine_ants_adapter"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "snapshots", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "amount_cents",    default: 0,     null: false
    t.string   "amount_currency", default: "USD", null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "snapshots", ["account_id"], name: "index_snapshots_on_account_id"

  create_table "users", force: :cascade do |t|
    t.integer  "bank_id"
    t.string   "user"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "users", ["bank_id"], name: "index_users_on_bank_id"

end
