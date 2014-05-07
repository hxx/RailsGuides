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

ActiveRecord::Schema.define(version: 20140507143102) do

  create_table "another_products", force: true do |t|
    t.string "name"
    t.string "part_number"
  end

  create_table "customers_products", id: false, force: true do |t|
    t.integer "customer_id", null: false
    t.integer "product_id",  null: false
  end

  create_table "examples", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "examples", ["name"], name: "index_examples_on_name"

  create_table "overridings", force: true do |t|
    t.string  "part_number"
    t.decimal "price"
    t.integer "user_id"
  end

  add_index "overridings", ["user_id"], name: "index_overridings_on_user_id"

  create_table "products", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.decimal  "price",         precision: 5, scale: 2
    t.integer  "supplier_id"
    t.string   "supplier_type"
  end

  add_index "products", ["supplier_id", "supplier_type"], name: "index_products_on_supplier_id_and_supplier_type"
  add_index "products", ["user_id"], name: "index_products_on_user_id"

  create_table "publications", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "publication_type_id"
    t.integer  "publisher_id"
    t.string   "publisher_type"
    t.boolean  "single_issue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "publications", ["publication_type_id"], name: "index_publications_on_publication_type_id"

end
