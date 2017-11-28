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

ActiveRecord::Schema.define(version: 20171128115541) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachinary_files", force: :cascade do |t|
    t.string   "attachinariable_type"
    t.integer  "attachinariable_id"
    t.string   "scope"
    t.string   "public_id"
    t.string   "version"
    t.integer  "width"
    t.integer  "height"
    t.string   "format"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent", using: :btree
  end

  create_table "flats", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "monthly_price"
    t.integer  "number_of_flatmates"
    t.text     "amenities"
    t.string   "address"
    t.string   "lat"
    t.string   "lng"
    t.string   "neighborhood"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "requests", force: :cascade do |t|
    t.datetime "slot"
    t.integer  "status",     default: 0
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["user_id"], name: "index_requests_on_user_id", using: :btree
  end

  create_table "rooms", force: :cascade do |t|
    t.date     "move_in_date"
    t.date     "move_out_date"
    t.integer  "flat_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["flat_id"], name: "index_rooms_on_flat_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "flat_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "facebook_picture_url"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "token"
    t.datetime "token_expiry"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["flat_id"], name: "index_users_on_flat_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "viewings", force: :cascade do |t|
    t.datetime "start_time"
    t.integer  "duration"
    t.integer  "room_id"
    t.integer  "request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["request_id"], name: "index_viewings_on_request_id", using: :btree
    t.index ["room_id"], name: "index_viewings_on_room_id", using: :btree
  end

  add_foreign_key "requests", "users"
  add_foreign_key "rooms", "flats"
  add_foreign_key "users", "flats"
  add_foreign_key "viewings", "requests"
  add_foreign_key "viewings", "rooms"
end
