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

ActiveRecord::Schema.define(version: 20140724033530) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_requests", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.string   "company"
    t.string   "phone"
    t.string   "email"
    t.string   "occupation"
    t.string   "species",    default: [], array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authors", force: true do |t|
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authors", ["last_name"], name: "index_authors_on_last_name", unique: true, using: :btree

  create_table "paper_summaries", force: true do |t|
    t.integer  "trial_id"
    t.string   "title"
    t.text     "description"
    t.string   "species"
    t.boolean  "featured",              default: true
    t.integer  "position"
    t.string   "document"
    t.string   "document_size"
    t.string   "document_content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "paper_summaries", ["featured", "species"], name: "index_paper_summaries_on_featured_and_species", using: :btree
  add_index "paper_summaries", ["featured"], name: "index_paper_summaries_on_featured", using: :btree
  add_index "paper_summaries", ["species"], name: "index_paper_summaries_on_species", using: :btree

  create_table "papers", id: false, force: true do |t|
    t.integer  "source_id"
    t.text     "citation"
    t.string   "title"
    t.string   "location"
    t.integer  "author_id"
    t.string   "literature_type"
    t.string   "journal"
    t.string   "document"
    t.string   "document_size"
    t.string   "document_content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "papers", ["author_id"], name: "index_papers_on_author_id", using: :btree
  add_index "papers", ["journal"], name: "index_papers_on_journal", using: :btree
  add_index "papers", ["literature_type"], name: "index_papers_on_literature_type", using: :btree

  create_table "performance_measures", force: true do |t|
    t.integer  "trial_id"
    t.string   "measure"
    t.string   "control"
    t.string   "amaferm"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "performance_measures", ["trial_id"], name: "index_performance_measures_on_trial_id", using: :btree

  create_table "sales_aids", force: true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.string   "category"
    t.integer  "access_level",          default: 0
    t.string   "document"
    t.string   "document_size"
    t.string   "document_content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  add_index "sales_aids", ["access_level"], name: "index_sales_aids_on_access_level", using: :btree
  add_index "sales_aids", ["category"], name: "index_sales_aids_on_category", using: :btree
  add_index "sales_aids", ["user_id"], name: "index_sales_aids_on_user_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "trials", force: true do |t|
    t.integer  "paper_id"
    t.string   "source_sub_id"
    t.integer  "level",         default: 0
    t.integer  "year"
    t.text     "summary"
    t.string   "dose"
    t.float    "forage"
    t.float    "concentrate"
    t.string   "calculations",  default: [], array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trials", ["paper_id"], name: "index_trials_on_paper_id", using: :btree
  add_index "trials", ["year"], name: "index_trials_on_year", using: :btree

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
