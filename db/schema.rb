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

ActiveRecord::Schema.define(version: 20141229031708) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "pg_stat_statements"
  enable_extension "unaccent"

  create_table "blocks", force: :cascade do |t|
    t.integer  "blocker_id"
    t.integer  "blocked_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bookmarks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "bookmarkee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "recipient_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "hidden_from_user_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "abbreviation", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "credentials", force: :cascade do |t|
    t.boolean  "expires",                   default: false
    t.datetime "expires_at"
    t.integer  "user_id"
    t.string   "provider_name", limit: 255
    t.text     "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "crushes", force: :cascade do |t|
    t.integer  "crusher_id"
    t.integer  "crushee_id"
    t.boolean  "secret",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "diets", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "labels", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "lat_lngs", force: :cascade do |t|
    t.decimal  "lat",                    precision: 8, scale: 5
    t.decimal  "lng",                    precision: 8, scale: 5
    t.string   "username",   limit: 255
    t.string   "location",   limit: 255
    t.text     "avatar"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "conversation_id"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.text     "body"
    t.boolean  "unread",          default: true
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "my_labels", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "label_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: :cascade do |t|
    t.string   "image",      limit: 255
    t.boolean  "avatar"
    t.text     "caption"
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "providers", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "uid",           limit: 255
    t.integer  "user_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "handle",        limit: 255
    t.datetime "last_login_at"
    t.string   "ip_address",    limit: 255
  end

  create_table "red_flags", force: :cascade do |t|
    t.integer  "flaggable_id"
    t.string   "flaggable_type", limit: 255
    t.string   "slug",           limit: 255
    t.integer  "reporter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "red_flags", ["slug"], name: "index_red_flags_on_slug", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "abbreviation", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "users", force: :cascade do |t|
    t.date     "birthday"
    t.string   "name",                 limit: 255
    t.string   "username",             limit: 255
    t.string   "email",                limit: 255
    t.string   "city",                 limit: 255
    t.string   "zipcode",              limit: 255
    t.string   "me_gender",            limit: 255
    t.string   "me_gender_map",        limit: 255
    t.string   "you_gender",           limit: 255
    t.string   "you_gender_map",       limit: 255
    t.boolean  "visible",                          default: false
    t.text     "bio"
    t.integer  "label_id"
    t.integer  "state_id"
    t.integer  "country_id"
    t.integer  "diet_id"
    t.datetime "created_at",                                                                                                                     null: false
    t.datetime "updated_at",                                                                                                                     null: false
    t.datetime "agreed_to_terms_at"
    t.hstore   "settings"
    t.string   "canonical_username",   limit: 255
    t.string   "auth_token",           limit: 255
    t.string   "facebook_username",    limit: 255
    t.string   "instagram_username",   limit: 255
    t.string   "kik_username",         limit: 255
    t.string   "lastfm_username",      limit: 255
    t.string   "snapchat_username",    limit: 255
    t.string   "spotify_username",     limit: 255
    t.string   "thisismyjam_username", limit: 255
    t.string   "tumblr_username",      limit: 255
    t.string   "twitter_username",     limit: 255
    t.string   "vine_username",        limit: 255
    t.text     "website"
    t.integer  "photos_count",                     default: 0
    t.hstore   "drug_use",                         default: {"drugs"=>"never", "alcohol"=>"never", "marijuana"=>"never", "cigarettes"=>"never"}
  end

  add_index "users", ["created_at"], name: "index_users_on_created_at", using: :btree
  add_index "users", ["photos_count"], name: "index_users_on_photos_count", using: :btree
  add_index "users", ["state_id"], name: "index_users_on_state_id", using: :btree

  create_table "your_labels", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "label_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "label_type", limit: 255, default: "Label"
  end

end
