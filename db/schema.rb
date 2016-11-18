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

ActiveRecord::Schema.define(version: 20161019104454) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "birthdays", force: :cascade do |t|
    t.integer  "year"
    t.integer  "month"
    t.integer  "day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cards", force: :cascade do |t|
    t.integer  "suit_id"
    t.integer  "face_id"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["face_id"], name: "index_cards_on_face_id", using: :btree
    t.index ["suit_id"], name: "index_cards_on_suit_id", using: :btree
  end

  create_table "faces", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "interpretations", force: :cascade do |t|
    t.integer  "card_id"
    t.text     "explanation"
    t.integer  "reading"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["card_id"], name: "index_interpretations_on_card_id", using: :btree
  end

  create_table "lookups", force: :cascade do |t|
    t.integer  "birthday_id"
    t.string   "ip_address"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["birthday_id"], name: "index_lookups_on_birthday_id", using: :btree
  end

  create_table "places", force: :cascade do |t|
    t.integer  "card_id"
    t.integer  "spread_id"
    t.integer  "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_places_on_card_id", using: :btree
    t.index ["spread_id"], name: "index_places_on_spread_id", using: :btree
  end

  create_table "spreads", force: :cascade do |t|
    t.integer  "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suits", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "cards", "faces"
  add_foreign_key "cards", "suits"
  add_foreign_key "interpretations", "cards"
  add_foreign_key "lookups", "birthdays"
  add_foreign_key "places", "cards"
  add_foreign_key "places", "spreads"
end
