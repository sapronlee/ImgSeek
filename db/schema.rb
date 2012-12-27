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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121225082835) do

  create_table "logs", :force => true do |t|
    t.string   "ip"
    t.datetime "time"
    t.text     "msg"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pictures", :force => true do |t|
    t.integer  "place_id"
    t.integer  "scenic_id"
    t.string   "image"
    t.string   "image_type"
    t.integer  "image_size"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "title"
    t.binary   "sig",        :limit => 16777215
    t.integer  "siglen"
  end

  create_table "places", :force => true do |t|
    t.integer  "scenic_id"
    t.string   "name",                          :null => false
    t.text     "description"
    t.string   "audio"
    t.string   "audio_type"
    t.integer  "audio_size",     :default => 0
    t.string   "cover"
    t.string   "cover_type"
    t.integer  "cover_size",     :default => 0
    t.integer  "pictures_count", :default => 0
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "scenics", :force => true do |t|
    t.string   "name",                          :null => false
    t.integer  "pictures_count", :default => 0
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "places_count",   :default => 0
  end

  create_table "settings", :force => true do |t|
    t.string   "var",                      :null => false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", :limit => 30
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "settings", ["thing_type", "thing_id", "var"], :name => "index_settings_on_thing_type_and_thing_id_and_var", :unique => true

end
