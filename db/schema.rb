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

ActiveRecord::Schema.define(version: 20131209125353) do

  create_table "operators", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "country"
    t.string   "reg_code_prefix", limit: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "operators", ["email"], name: "index_operators_on_email", unique: true

  create_table "player_groups", force: true do |t|
    t.integer  "operator_id"
    t.string   "reg_code"
    t.date     "program_start_date"
    t.string   "name"
    t.text     "description"
    t.integer  "player_organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "player_groups", ["operator_id"], name: "index_player_groups_on_operator_id"
  add_index "player_groups", ["player_organization_id"], name: "index_player_groups_on_player_organization_id"
  add_index "player_groups", ["reg_code"], name: "index_player_groups_on_reg_code"

  create_table "player_organizations", force: true do |t|
    t.string   "org_type"
    t.string   "name"
    t.text     "address"
    t.string   "contact_name"
    t.string   "contact_position"
    t.string   "contact_email"
    t.string   "contact_phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "operator_id"
  end

  add_index "player_organizations", ["operator_id"], name: "index_player_organizations_on_operator_id"

  create_table "system_admins", force: true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "system_admins", ["email"], name: "index_system_admins_on_email", unique: true

end
