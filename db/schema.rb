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

ActiveRecord::Schema.define(version: 20141121073954) do

  create_table "implements", id: false, force: true do |t|
    t.string   "uuid",                limit: 36,                 null: false
    t.string   "name",                limit: 50,                 null: false
    t.date     "year"
    t.string   "implement_type_uuid", limit: 36,                 null: false
    t.float    "value",               limit: 24
    t.boolean  "own",                            default: false
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "labors", id: false, force: true do |t|
    t.string   "uuid",               limit: 36, null: false
    t.string   "name",               limit: 50, null: false
    t.string   "position_uuid",      limit: 36, null: false
    t.string   "labor_project_uuid", limit: 36
    t.string   "labor_subordinate",  limit: 36
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "maintenances", id: false, force: true do |t|
    t.string   "uuid",           limit: 36, null: false
    t.string   "machinery_uuid", limit: 36, null: false
    t.string   "labor_uuid",     limit: 36
    t.integer  "engine_hours"
    t.integer  "time_spent"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tractors", id: false, force: true do |t|
    t.string   "uuid",               limit: 36,                 null: false
    t.string   "name",               limit: 50,                 null: false
    t.float    "horse_power",        limit: 24
    t.float    "fuel_capacity",      limit: 24
    t.string   "make"
    t.string   "model"
    t.date     "year"
    t.float    "value",              limit: 24
    t.boolean  "own",                           default: false
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "users", id: false, force: true do |t|
    t.string   "uuid",                   limit: 36,                null: false
    t.string   "name",                   limit: 50
    t.string   "email",                             default: "",   null: false
    t.string   "encrypted_password",                default: "",   null: false
    t.boolean  "active",                            default: true, null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
