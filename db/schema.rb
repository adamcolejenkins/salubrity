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

ActiveRecord::Schema.define(version: 20141013180347) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: true do |t|
    t.integer  "response_id"
    t.integer  "field_id"
    t.text     "value"
    t.time     "started_at"
    t.time     "ended_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["field_id"], name: "index_answers_on_field_id", using: :btree
  add_index "answers", ["response_id"], name: "index_answers_on_response_id", using: :btree

  create_table "clinics", force: true do |t|
    t.string   "title"
    t.integer  "survey_id"
    t.string   "guid"
    t.string   "address"
    t.string   "address2"
    t.string   "city"
    t.string   "state",      limit: 2
    t.integer  "zip",        limit: 8
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clinics", ["survey_id"], name: "index_clinics_on_survey_id", using: :btree

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

  create_table "field_options", force: true do |t|
    t.integer  "field_id"
    t.string   "meta_key"
    t.text     "meta_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "field_options", ["field_id"], name: "index_field_options_on_field_id", using: :btree

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

  create_table "providers", force: true do |t|
    t.integer  "clinic_id"
    t.string   "name"
    t.string   "position"
    t.string   "email"
    t.string   "phone"
    t.string   "photo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "providers", ["clinic_id"], name: "index_providers_on_clinic_id", using: :btree

  create_table "responses", force: true do |t|
    t.integer  "survey_id"
    t.integer  "clinic_id"
    t.integer  "provider_id"
    t.time     "started_at"
    t.time     "ended_at"
    t.text     "user_agent"
    t.string   "ip_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "responses", ["clinic_id"], name: "index_responses_on_clinic_id", using: :btree
  add_index "responses", ["provider_id"], name: "index_responses_on_provider_id", using: :btree
  add_index "responses", ["survey_id"], name: "index_responses_on_survey_id", using: :btree

  create_table "survey_options", force: true do |t|
    t.integer  "survey_id"
    t.string   "meta_key"
    t.text     "meta_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "survey_options", ["survey_id"], name: "index_survey_options_on_survey_id", using: :btree

  create_table "surveys", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "guid"
    t.string   "status",          default: "draft"
    t.boolean  "scheduled",       default: false
    t.datetime "scheduled_start"
    t.datetime "scheduled_stop"
    t.time     "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "opts"
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
