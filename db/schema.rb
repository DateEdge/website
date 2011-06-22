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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110622031541) do

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "diets", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "labels", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "my_labels", :force => true do |t|
    t.integer  "user_id"
    t.integer  "label_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", :force => true do |t|
    t.string   "image_content_type"
    t.string   "image_file_name"
    t.datetime "image_updated_at"
    t.integer  "image_file_size"
    t.text     "caption"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", :force => true do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.date     "birthday"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "username"
    t.string   "email"
    t.string   "city"
    t.string   "zipcode"
    t.string   "me_gender"
    t.string   "me_gender_map"
    t.string   "you_gender"
    t.string   "you_gender_map"
    t.text     "bio"
    t.integer  "label_id"
    t.integer  "state_id"
    t.integer  "country_id"
    t.integer  "diet_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "your_labels", :force => true do |t|
    t.integer  "user_id"
    t.integer  "label_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
