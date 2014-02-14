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

ActiveRecord::Schema.define(version: 20140214195059) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: true do |t|
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authors", ["last_name"], name: "index_authors_on_last_name", unique: true, using: :btree

  create_table "papers", id: false, force: true do |t|
    t.string   "source_id"
    t.string   "citation"
    t.integer  "level",           default: 0
    t.integer  "author_id"
    t.integer  "dose"
    t.integer  "year"
    t.string   "literature_type"
    t.string   "journal"
    t.text     "species",         default: [], array: true
    t.float    "forage"
    t.float    "concentrate"
    t.string   "document"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "papers", ["author_id"], name: "index_papers_on_author_id", using: :btree
  add_index "papers", ["journal"], name: "index_papers_on_journal", using: :btree
  add_index "papers", ["literature_type"], name: "index_papers_on_literature_type", using: :btree
  add_index "papers", ["species"], name: "index_papers_on_species", using: :gin
  add_index "papers", ["year"], name: "index_papers_on_year", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                       null: false
    t.string   "password_digest"
    t.integer  "role",            default: 0
    t.string   "avatar"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["role"], name: "index_users_on_role", using: :btree

end
