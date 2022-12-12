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

ActiveRecord::Schema.define(version: 20160311194128) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "label",       limit: 50
    t.string   "address"
    t.string   "city",        limit: 30
    t.string   "state",       limit: 2,  default: "CA"
    t.string   "zip",         limit: 10
    t.integer  "customer_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "addresses", ["customer_id"], name: "index_addresses_on_customer_id", using: :btree

  create_table "crono_jobs", force: :cascade do |t|
    t.string   "job_id",            null: false
    t.text     "log"
    t.datetime "last_performed_at"
    t.boolean  "healthy"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "crono_jobs", ["job_id"], name: "index_crono_jobs_on_job_id", unique: true, using: :btree

  create_table "customers", force: :cascade do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.string   "company_name"
    t.string   "phone_home"
    t.string   "phone_work"
    t.string   "phone_mobile1"
    t.string   "phone_mobile2"
    t.string   "email"
    t.string   "address"
    t.string   "city"
    t.string   "state",         limit: 2
    t.string   "zip"
    t.text     "note"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "discounts", force: :cascade do |t|
    t.string   "name",       limit: 20
    t.decimal  "value"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "events", force: :cascade do |t|
    t.date     "date"
    t.time     "time_start"
    t.time     "time_end"
    t.text     "note"
    t.integer  "customer_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "color"
    t.string   "description", limit: 100
    t.string   "city",        limit: 30
    t.integer  "invoice_id"
  end

  add_index "events", ["customer_id"], name: "index_events_on_customer_id", using: :btree
  add_index "events", ["invoice_id"], name: "index_events_on_invoice_id", using: :btree

  create_table "invoice_images", force: :cascade do |t|
    t.string   "name"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "invoice_items", force: :cascade do |t|
    t.string   "description"
    t.string   "dimensions"
    t.money    "unit_cost",   scale: 2
    t.money    "total_cost",  scale: 2
    t.integer  "service_id"
    t.integer  "invoice_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "invoice_items", ["invoice_id"], name: "index_invoice_items_on_invoice_id", using: :btree
  add_index "invoice_items", ["service_id"], name: "index_invoice_items_on_service_id", using: :btree

  create_table "invoices", force: :cascade do |t|
    t.date     "service_date"
    t.time     "service_time"
    t.date     "date"
    t.boolean  "paid",                   default: false
    t.text     "note"
    t.money    "total",        scale: 2
    t.integer  "customer_id"
    t.integer  "event_id"
    t.integer  "discount_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "invoices", ["customer_id"], name: "index_invoices_on_customer_id", using: :btree
  add_index "invoices", ["discount_id"], name: "index_invoices_on_discount_id", using: :btree
  add_index "invoices", ["event_id"], name: "index_invoices_on_event_id", using: :btree

  create_table "labels", force: :cascade do |t|
    t.string   "name"
    t.decimal  "top_margin"
    t.decimal  "bottom_margin"
    t.decimal  "left_margin"
    t.decimal  "right_margin"
    t.integer  "columns"
    t.integer  "rows"
    t.decimal  "column_gutter"
    t.decimal  "row_gutter"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "notes", force: :cascade do |t|
    t.text     "note_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "status"
  end

  create_table "phones", force: :cascade do |t|
    t.string   "number",      limit: 20,                 null: false
    t.string   "label",       limit: 20,                 null: false
    t.boolean  "textable",               default: false
    t.integer  "customer_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "phones", ["customer_id"], name: "index_phones_on_customer_id", using: :btree

# Could not dump table "reminders" because of following StandardError
#   Unknown type 'reminder_method' for column 'reminder_method'

  create_table "services", force: :cascade do |t|
    t.string   "name"
    t.money    "price",      scale: 2
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "settings", force: :cascade do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "login"
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "addresses", "customers"
  add_foreign_key "events", "customers"
  add_foreign_key "events", "invoices"
  add_foreign_key "invoice_items", "invoices", on_delete: :cascade
  add_foreign_key "invoice_items", "services"
  add_foreign_key "invoices", "customers"
  add_foreign_key "invoices", "discounts"
  add_foreign_key "invoices", "events"
  add_foreign_key "phones", "customers"
  add_foreign_key "reminders", "customers"
end
