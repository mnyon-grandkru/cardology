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

ActiveRecord::Schema.define(version: 2024_09_17_221923) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_stat_statements"
  enable_extension "plpgsql"

  create_table "birthdays", id: :serial, force: :cascade do |t|
    t.integer "year"
    t.integer "month"
    t.integer "day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cards", id: :serial, force: :cascade do |t|
    t.integer "suit_id"
    t.integer "face_id"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["face_id"], name: "index_cards_on_face_id"
    t.index ["suit_id"], name: "index_cards_on_suit_id"
  end

  create_table "celestials", force: :cascade do |t|
    t.bigint "birthday_id"
    t.bigint "member_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["birthday_id"], name: "index_celestials_on_birthday_id"
    t.index ["member_id"], name: "index_celestials_on_member_id"
  end

  create_table "faces", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number"
  end

  create_table "interpretations", id: :serial, force: :cascade do |t|
    t.integer "card_id"
    t.text "explanation"
    t.integer "reading"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_interpretations_on_card_id"
  end

  create_table "interviews", force: :cascade do |t|
    t.boolean "unused"
    t.boolean "elsewhere"
    t.boolean "cumbersome"
    t.text "thoughts"
    t.bigint "member_id"
    t.string "braintree_subscription_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "expense"
    t.boolean "accuracy"
    t.boolean "specific"
    t.boolean "applicable"
    t.index ["member_id"], name: "index_interviews_on_member_id"
  end

  create_table "lookups", id: :serial, force: :cascade do |t|
    t.integer "birthday_id"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["birthday_id"], name: "index_lookups_on_birthday_id"
  end

  create_table "members", id: :serial, force: :cascade do |t|
    t.integer "birthday_id"
    t.integer "lookup_id"
    t.string "name"
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
    t.integer "zodiac_sign"
    t.string "braintree_id"
    t.integer "subscription_status"
    t.text "subscriptions"
    t.datetime "due_date"
    t.text "campaigns"
    t.index ["birthday_id"], name: "index_members_on_birthday_id"
    t.index ["email"], name: "index_members_on_email", unique: true
    t.index ["lookup_id"], name: "index_members_on_lookup_id"
    t.index ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true
  end

  create_table "places", id: :serial, force: :cascade do |t|
    t.integer "card_id"
    t.integer "spread_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_places_on_card_id"
    t.index ["spread_id"], name: "index_places_on_spread_id"
  end

  create_table "quotes", id: :serial, force: :cascade do |t|
    t.string "source"
    t.text "phrasing"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spreads", id: :serial, force: :cascade do |t|
    t.integer "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suits", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "cards", "faces"
  add_foreign_key "cards", "suits"
  add_foreign_key "celestials", "birthdays"
  add_foreign_key "celestials", "members"
  add_foreign_key "interpretations", "cards"
  add_foreign_key "interviews", "members"
  add_foreign_key "lookups", "birthdays"
  add_foreign_key "places", "cards"
  add_foreign_key "places", "spreads"
end
