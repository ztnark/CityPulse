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

ActiveRecord::Schema.define(version: 20131114165218) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "eventbrites", force: true do |t|
    t.string   "title"
    t.string   "venue"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "at_time"
    t.string   "eventbrite_id"
    t.string   "thumb"
    t.string   "url"
    t.string   "city"
    t.string   "address"
    t.string   "state"
    t.string   "postal_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "title"
    t.string   "venue_name"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "start_time"
    t.datetime "stop_time"
    t.string   "at_time"
    t.string   "eventful_id"
    t.string   "thumb"
    t.string   "url"
    t.string   "city_name"
    t.string   "venue_address"
    t.string   "region_abbr"
    t.string   "postal_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
