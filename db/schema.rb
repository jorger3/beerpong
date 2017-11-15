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

ActiveRecord::Schema.define(version: 20171115033620) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bp_logs", force: :cascade do |t|
    t.bigint "user_id"
    t.string "table"
    t.integer "data_id"
    t.string "action"
    t.string "controller"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bp_logs_on_user_id"
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "tournament_id"
    t.integer "winner_one"
    t.integer "winner_two"
    t.integer "loser_one"
    t.integer "loser_two"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tournament_id"], name: "index_matches_on_tournament_id"
    t.index ["user_id"], name: "index_matches_on_user_id"
  end

  create_table "matches_players", force: :cascade do |t|
    t.bigint "match_id"
    t.bigint "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_matches_players_on_match_id"
    t.index ["player_id"], name: "index_matches_players_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.integer "wins"
    t.integer "loses"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_players_on_user_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.integer "season"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tournaments_on_user_id"
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
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "access_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "matches", "tournaments"
end
