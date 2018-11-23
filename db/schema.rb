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

ActiveRecord::Schema.define(version: 2018_11_23_005704) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admissions", force: :cascade do |t|
    t.integer "enem_grade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "student_id"
    t.integer "status"
    t.index ["student_id"], name: "index_admissions_on_student_id"
  end

  create_table "billings", force: :cascade do |t|
    t.integer "desired_due_day"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "student_id"
    t.integer "parcels_number", default: 0
    t.index ["student_id"], name: "index_billings_on_student_id"
  end

  create_table "bills", force: :cascade do |t|
    t.decimal "value"
    t.datetime "due_date"
    t.datetime "paid_date"
    t.integer "status"
    t.integer "month"
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "billing_id"
    t.index ["billing_id"], name: "index_bills_on_billing_id"
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "value"
    t.string "status"
    t.string "method"
    t.datetime "expiry_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.string "cpf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
