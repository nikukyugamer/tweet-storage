# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2020_06_12_023837) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "lists", force: :cascade do |t|
    t.bigint "id_number", null: false
    t.string "name", null: false
    t.string "slug", null: false
    t.json "serialized_object", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "search_word"
    t.integer "list_id"
    t.bigint "user_id_number"
    t.bigint "list_id_number"
    t.datetime "tweeted_at", precision: nil, default: "2000-01-01 12:00:00", null: false
    t.index ["id_number"], name: "index_tweets_on_id_number"
    t.index ["list_id_number"], name: "index_tweets_on_list_id_number"
    t.index ["search_word"], name: "index_tweets_on_search_word"
    t.index ["type"], name: "index_tweets_on_type"
    t.index ["user_id_number"], name: "index_tweets_on_user_id_number"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "id_number", null: false
    t.string "handle", null: false
    t.string "screen_name", null: false
    t.json "serialized_object", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["handle"], name: "index_users_on_handle"
    t.index ["id_number"], name: "index_users_on_id_number"
    t.index ["screen_name"], name: "index_users_on_screen_name"
  end

end
