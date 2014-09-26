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

ActiveRecord::Schema.define(version: 20140922211756) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "field_choices", force: true do |t|
    t.integer  "field_id"
    t.string   "label"
    t.string   "key"
    t.time     "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "priority"
  end

  add_index "field_choices", ["field_id"], name: "index_field_choices_on_field_id", using: :btree

  create_table "fields", force: true do |t|
    t.integer  "survey_id"
    t.text     "label"
    t.string   "field_type",       limit: 30
    t.text     "opts"
    t.boolean  "required"
    t.string   "visibility",                  default: "public"
    t.string   "predefined_value"
    t.time     "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "priority"
  end

  add_index "fields", ["survey_id"], name: "index_fields_on_survey_id", using: :btree

  create_table "surveys", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "guid"
    t.string   "logo_path"
    t.string   "status",          default: "draft"
    t.boolean  "scheduled",       default: false
    t.datetime "scheduled_start"
    t.datetime "scheduled_stop"
    t.time     "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
    t.string   "name"
    t.string   "username",               default: "",    null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
