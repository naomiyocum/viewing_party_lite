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

ActiveRecord::Schema[7.0].define(version: 2022_12_13_233239) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "user_view_parties", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "view_party_id"
    t.boolean "host", default: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["user_id"], name: "index_user_view_parties_on_user_id"
    t.index ["view_party_id"], name: "index_user_view_parties_on_view_party_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "role", default: 0
  end

  create_table "view_parties", force: :cascade do |t|
    t.integer "movie_id"
    t.string "movie_name"
    t.integer "duration"
    t.datetime "datetime", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  add_foreign_key "user_view_parties", "users"
  add_foreign_key "user_view_parties", "view_parties"
end
