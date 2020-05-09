# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_09_111938) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "list_tweets", force: :cascade do |t|
    t.integer "list_id"
    t.integer "tweet_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lists", force: :cascade do |t|
    t.bigint "id_number", null: false
    t.string "name", null: false
    t.string "slug", null: false
    t.json "serialized_object", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["id_number"], name: "index_lists_on_id_number"
    t.index ["name"], name: "index_lists_on_name"
    t.index ["slug"], name: "index_lists_on_slug"
  end

  create_table "tweets", force: :cascade do |t|
    t.integer "user_id", null: false
    t.bigint "id_number", null: false
    t.string "full_text", null: false
    t.json "serialized_object", null: false
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "list_id_number"
    t.string "list_name"
    t.json "list_serialized_object"
    t.string "search_word"
    t.index ["id_number"], name: "index_tweets_on_id_number"
    t.index ["search_word"], name: "index_tweets_on_search_word"
    t.index ["type"], name: "index_tweets_on_type"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "id_number", null: false
    t.string "handle", null: false
    t.string "screen_name", null: false
    t.json "serialized_object", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["handle"], name: "index_users_on_handle"
    t.index ["id_number"], name: "index_users_on_id_number"
    t.index ["screen_name"], name: "index_users_on_screen_name"
  end
end
