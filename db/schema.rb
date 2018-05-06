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

ActiveRecord::Schema.define(version: 2018_05_05_013555) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bulletins", force: :cascade do |t|
    t.text "body"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_bulletins_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_bulletins_on_user_id"
  end

  create_table "bumps", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id"], name: "index_bumps_on_topic_id"
    t.index ["user_id"], name: "index_bumps_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.bigint "user_id"
    t.bigint "bulletin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bulletin_id", "created_at"], name: "index_comments_on_bulletin_id_and_created_at"
    t.index ["bulletin_id"], name: "index_comments_on_bulletin_id"
    t.index ["user_id", "created_at"], name: "index_comments_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "objections", force: :cascade do |t|
    t.string "body"
    t.bigint "user_id"
    t.bigint "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id", "created_at"], name: "index_objections_on_topic_id_and_created_at"
    t.index ["topic_id"], name: "index_objections_on_topic_id"
    t.index ["user_id", "created_at"], name: "index_objections_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_objections_on_user_id"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id"
  end

  create_table "replies", force: :cascade do |t|
    t.text "body"
    t.boolean "anonymous", default: true
    t.bigint "user_id"
    t.bigint "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id", "created_at"], name: "index_replies_on_topic_id_and_created_at"
    t.index ["topic_id"], name: "index_replies_on_topic_id"
    t.index ["user_id", "created_at"], name: "index_replies_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_replies_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.bigint "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id", "created_at"], name: "index_tags_on_topic_id_and_created_at"
    t.index ["topic_id"], name: "index_tags_on_topic_id"
    t.index ["user_id", "created_at"], name: "index_tags_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_tags_on_user_id"
  end

  create_table "topics", force: :cascade do |t|
    t.text "subject"
    t.boolean "anonymous", default: true
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_topics_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_topics_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bulletins", "users"
  add_foreign_key "bumps", "topics"
  add_foreign_key "bumps", "users"
  add_foreign_key "comments", "bulletins"
  add_foreign_key "comments", "users"
  add_foreign_key "objections", "topics"
  add_foreign_key "objections", "users"
  add_foreign_key "replies", "topics"
  add_foreign_key "replies", "users"
  add_foreign_key "tags", "topics"
  add_foreign_key "tags", "users"
  add_foreign_key "topics", "users"
end
