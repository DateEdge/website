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

ActiveRecord::Schema.define(version: 20140428230607) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "pg_stat_statements"
  enable_extension "unaccent"

  create_table "blocks", force: true do |t|
    t.integer  "blocker_id"
    t.integer  "blocked_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bookmarks", force: true do |t|
    t.integer  "user_id"
    t.integer  "bookmarkee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conversations", force: true do |t|
    t.integer  "user_id"
    t.integer  "recipient_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "hidden_from_user_id"
  end

  create_table "countries", force: true do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "crushes", force: true do |t|
    t.integer  "crusher_id"
    t.integer  "crushee_id"
    t.boolean  "secret",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "diets", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "labels", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: true do |t|
    t.integer  "conversation_id"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.text     "body"
    t.boolean  "unread",          default: true
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "my_labels", force: true do |t|
    t.integer  "user_id"
    t.integer  "label_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.string   "image"
    t.boolean  "avatar"
    t.text     "caption"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "providers", force: true do |t|
    t.string   "name"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "handle"
    t.datetime "last_login_at"
    t.string   "ip_address"
  end

  create_table "states", force: true do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: true do |t|
    t.date     "birthday"
    t.string   "name"
    t.string   "username"
    t.string   "email"
    t.string   "city"
    t.string   "zipcode"
    t.string   "me_gender"
    t.string   "me_gender_map"
    t.string   "you_gender"
    t.string   "you_gender_map"
    t.boolean  "visible",              default: false
    t.text     "bio"
    t.integer  "label_id"
    t.integer  "state_id"
    t.integer  "country_id"
    t.integer  "diet_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.datetime "agreed_to_terms_at"
    t.hstore   "settings"
    t.string   "canonical_username"
    t.string   "auth_token"
    t.string   "facebook_username"
    t.string   "instagram_username"
    t.string   "kik_username"
    t.string   "lastfm_username"
    t.string   "snapchat_username"
    t.string   "spotify_username"
    t.string   "thisismyjam_username"
    t.string   "tumblr_username"
    t.string   "twitter_username"
    t.string   "vine_username"
    t.text     "website"
    t.integer  "photos_count",         default: 0
  end

  add_index "users", ["created_at"], name: "index_users_on_created_at", using: :btree
  add_index "users", ["photos_count"], name: "index_users_on_photos_count", using: :btree
  add_index "users", ["state_id"], name: "index_users_on_state_id", using: :btree

  create_table "your_labels", force: true do |t|
    t.integer  "user_id"
    t.integer  "label_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "label_type", default: "Label"
  end

end
