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

ActiveRecord::Schema.define(version: 2020_10_17_101422) do

  create_table "book_records", force: :cascade do |t|
    t.integer "direction"
    t.integer "category"
    t.integer "amount"
    t.date "record_date"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "comment"
    t.string "name"
    t.string "contact"
    t.time "started_at"
    t.time "finished_at"
    t.integer "number"
    t.string "writer"
    t.index ["user_id", "record_date"], name: "index_book_records_on_user_id_and_record_date"
    t.index ["user_id"], name: "index_book_records_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
  end

  create_table "daily_balances", force: :cascade do |t|
    t.integer "expenditure"
    t.integer "income"
    t.date "record_date"
    t.integer "user_id"
    t.index ["user_id", "record_date"], name: "index_daily_balances_on_user_id_and_record_date", unique: true
    t.index ["user_id"], name: "index_daily_balances_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "img"
    t.string "header_image"
    t.string "remember_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
