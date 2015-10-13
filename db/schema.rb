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

ActiveRecord::Schema.define(version: 20151013124540) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: :cascade do |t|
    t.integer  "game_id",    null: false
    t.string   "type",       null: false
    t.integer  "tile_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "actions", ["game_id"], name: "index_actions_on_game_id", using: :btree

  create_table "fields", force: :cascade do |t|
    t.integer  "game_id",    null: false
    t.integer  "user_id"
    t.string   "type",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "fields", ["game_id"], name: "index_fields_on_game_id", using: :btree
  add_index "fields", ["user_id"], name: "index_fields_on_user_id", using: :btree

  create_table "games", force: :cascade do |t|
    t.integer  "room_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "games", ["room_id"], name: "index_games_on_room_id", using: :btree

  create_table "joins", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "room_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "joins", ["room_id"], name: "index_joins_on_room_id", using: :btree
  add_index "joins", ["user_id"], name: "index_joins_on_user_id", using: :btree

  create_table "rooms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tiles", force: :cascade do |t|
    t.integer  "field_id",   null: false
    t.string   "kind",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tiles", ["field_id"], name: "index_tiles_on_field_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "actions", "games"
  add_foreign_key "actions", "tiles"
  add_foreign_key "actions", "users"
  add_foreign_key "fields", "games"
  add_foreign_key "fields", "users"
  add_foreign_key "games", "rooms"
  add_foreign_key "joins", "rooms"
  add_foreign_key "joins", "users"
  add_foreign_key "tiles", "fields"
end
