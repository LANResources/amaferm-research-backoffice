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

ActiveRecord::Schema.define(version: 20180507195241) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_requests", force: :cascade do |t|
    t.string   "first_name", limit: 255
    t.string   "last_name",  limit: 255
    t.string   "title",      limit: 255
    t.string   "company",    limit: 255
    t.string   "phone",      limit: 255
    t.string   "email",      limit: 255
    t.string   "occupation", limit: 255
    t.string   "species",    limit: 255, default: [], array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authors", force: :cascade do |t|
    t.string   "last_name",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authors", ["last_name"], name: "index_authors_on_last_name", unique: true, using: :btree

  create_table "paper_summaries", force: :cascade do |t|
    t.integer  "trial_id"
    t.string   "title",                 limit: 255
    t.text     "description"
    t.string   "species",               limit: 255
    t.boolean  "featured",                          default: true
    t.integer  "position"
    t.string   "document",              limit: 255
    t.string   "document_size",         limit: 255
    t.string   "document_content_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "paper_summaries", ["featured", "species"], name: "index_paper_summaries_on_featured_and_species", using: :btree
  add_index "paper_summaries", ["featured"], name: "index_paper_summaries_on_featured", using: :btree
  add_index "paper_summaries", ["species"], name: "index_paper_summaries_on_species", using: :btree

  create_table "papers", id: false, force: :cascade do |t|
    t.integer  "source_id"
    t.text     "citation"
    t.string   "title",                 limit: 255
    t.string   "location",              limit: 255
    t.integer  "author_id"
    t.string   "literature_type",       limit: 255
    t.string   "journal",               limit: 255
    t.string   "document",              limit: 255
    t.string   "document_size",         limit: 255
    t.string   "document_content_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "product"
  end

  add_index "papers", ["author_id"], name: "index_papers_on_author_id", using: :btree
  add_index "papers", ["journal"], name: "index_papers_on_journal", using: :btree
  add_index "papers", ["literature_type"], name: "index_papers_on_literature_type", using: :btree

  create_table "performance_measures", force: :cascade do |t|
    t.integer  "trial_id"
    t.string   "measure",          limit: 255
    t.string   "control",          limit: 255
    t.string   "amaferm",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rumensin"
    t.string   "amaferm_rumensin"
  end

  add_index "performance_measures", ["trial_id"], name: "index_performance_measures_on_trial_id", using: :btree

  create_table "sales_aids", force: :cascade do |t|
    t.string   "title",                 limit: 255
    t.integer  "user_id"
    t.string   "category",              limit: 255
    t.integer  "access_level",                      default: 0
    t.string   "document",              limit: 255
    t.string   "document_size",         limit: 255
    t.string   "document_content_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.string   "video_id",              limit: 255
    t.text     "video_data"
    t.string   "link",                  limit: 255
  end

  add_index "sales_aids", ["access_level"], name: "index_sales_aids_on_access_level", using: :btree
  add_index "sales_aids", ["category"], name: "index_sales_aids_on_category", using: :btree
  add_index "sales_aids", ["user_id"], name: "index_sales_aids_on_user_id", using: :btree

  create_table "supplementals", force: :cascade do |t|
    t.integer  "paper_id"
    t.integer  "source_sub_id"
    t.string   "title",                 limit: 255
    t.integer  "year"
    t.integer  "author_id"
    t.text     "citation"
    t.string   "literature_type",       limit: 255
    t.text     "summary"
    t.integer  "level",                             default: 0
    t.string   "document",              limit: 255
    t.string   "document_size",         limit: 255
    t.string   "document_content_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "supplementals", ["author_id"], name: "index_supplementals_on_author_id", using: :btree
  add_index "supplementals", ["paper_id"], name: "index_supplementals_on_paper_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id"
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count",             default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "trials", force: :cascade do |t|
    t.integer  "paper_id"
    t.string   "source_sub_id", limit: 255
    t.integer  "level",                     default: 0
    t.integer  "year"
    t.text     "summary"
    t.string   "dose",          limit: 255
    t.string   "forage"
    t.string   "concentrate"
    t.string   "calculations",  limit: 255, default: [], array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trials", ["paper_id"], name: "index_trials_on_paper_id", using: :btree
  add_index "trials", ["year"], name: "index_trials_on_year", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.string   "email",           limit: 255,             null: false
    t.string   "password_digest", limit: 255
    t.integer  "role",                        default: 0
    t.string   "avatar",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["role"], name: "index_users_on_role", using: :btree

end
