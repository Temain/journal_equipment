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

ActiveRecord::Schema.define(version: 20140503123403) do

  create_table "categories", force: true do |t|
    t.string "name", null: false
  end

  create_table "departments", force: true do |t|
    t.string   "name",                   null: false
    t.string   "materially_responsible"
    t.integer  "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "equipment", force: true do |t|
    t.integer  "equipment_type_id",                 null: false
    t.integer  "department_id",                     null: false
    t.integer  "inventory_number"
    t.boolean  "writed_off",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "equipment_types", force: true do |t|
    t.string  "name",         null: false
    t.integer "category_id",  null: false
    t.string  "manufacturer", null: false
    t.string  "abbreviation"
  end

  create_table "journal_records", force: true do |t|
    t.integer  "journalable_id"
    t.string   "journalable_type"
    t.integer  "equipment_id",     null: false
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relocations", force: true do |t|
    t.integer "department_id", null: false
  end

  create_table "repairs", force: true do |t|
    t.string  "reason"
    t.integer "spare_id"
  end

  create_table "spares", force: true do |t|
    t.string  "name"
    t.integer "equipment_type_id"
  end

end