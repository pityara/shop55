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

ActiveRecord::Schema.define(version: 20170716075204) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "docs", force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.string "number"
    t.text "logs"
    t.boolean "signed"
    t.boolean "agreed"
    t.text "resolution"
    t.boolean "done"
    t.bigint "initiator_id"
    t.bigint "destination_id"
    t.bigint "signer_id"
    t.bigint "executor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "image_data"
    t.boolean "refused", default: false
    t.index ["destination_id"], name: "index_docs_on_destination_id"
    t.index ["executor_id"], name: "index_docs_on_executor_id"
    t.index ["initiator_id"], name: "index_docs_on_initiator_id"
    t.index ["signer_id"], name: "index_docs_on_signer_id"
  end

  create_table "docs_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "doc_id", null: false
    t.index ["doc_id", "user_id"], name: "index_docs_users_on_doc_id_and_user_id"
    t.index ["user_id", "doc_id"], name: "index_docs_users_on_user_id_and_doc_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "docs", "users", column: "destination_id"
  add_foreign_key "docs", "users", column: "executor_id"
  add_foreign_key "docs", "users", column: "initiator_id"
  add_foreign_key "docs", "users", column: "signer_id"
end
