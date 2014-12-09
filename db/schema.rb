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

ActiveRecord::Schema.define(version: 20141206022103) do

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

  create_table "resource_users", id: false, force: true do |t|
    t.string   "resource_id"
    t.string   "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resources", id: false, force: true do |t|
    t.string   "uuid",       limit: 36,                null: false
    t.string   "name",       limit: 50,                null: false
    t.string   "label",      limit: 50
    t.text     "note"
    t.boolean  "active",                default: true, null: false
    t.boolean  "boolean",               default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", id: false, force: true do |t|
    t.string   "uuid",          limit: 36, null: false
    t.string   "resource_id",   limit: 36
    t.string   "name"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "note"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

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

  create_table "user_groups", id: false, force: true do |t|
    t.string   "uuid",       limit: 36,                null: false
    t.string   "name",       limit: 50,                null: false
    t.text     "note"
    t.boolean  "active",                default: true, null: false
    t.boolean  "boolean",               default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "label"
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
    t.text     "note"
    t.string   "role"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.string "user_id", limit: 36, null: false
    t.string "role_id", limit: 36, null: false
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "warehouse_types", id: false, force: true do |t|
    t.string   "uuid",       limit: 36,                null: false
    t.string   "name",       limit: 50,                null: false
    t.text     "note"
    t.boolean  "active",                default: true, null: false
    t.boolean  "boolean",               default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "warehouses", id: false, force: true do |t|
    t.string   "uuid",                limit: 36,                null: false
    t.string   "name",                limit: 50,                null: false
    t.string   "labor_uuid",          limit: 36
    t.string   "warehouse_type_uuid", limit: 36
    t.string   "address"
    t.text     "note"
    t.boolean  "active",                         default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
