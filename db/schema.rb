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

ActiveRecord::Schema.define(version: 2020_05_30_095630) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.string "title"
    t.string "name"
    t.string "email"
    t.string "phone"
    t.text "message"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "cvs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "working_skills", limit: 255
    t.date "birth_date"
    t.string "about", limit: 255
    t.string "skills", limit: 255
    t.string "future_plans", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "interests", limit: 255
    t.string "headshot_file_name", limit: 255
    t.string "headshot_content_type", limit: 255
    t.bigint "headshot_file_size"
    t.datetime "headshot_updated_at"
    t.string "gender", limit: 1, default: "f"
    t.string "birth_place", limit: 255
    t.string "birth_day"
    t.string "birth_month"
    t.string "birth_year"
    t.boolean "published", default: false
    t.string "learning_skills"
    t.datetime "published_at"
    t.string "authorization_statement", limit: 255
    t.boolean "publish_last_name", default: false
    t.index ["user_id"], name: "index_cvs_on_user_id"
  end

  create_table "educations", force: :cascade do |t|
    t.bigint "cv_id", null: false
    t.date "started_on"
    t.date "ended_on"
    t.string "degree", limit: 255
    t.string "school", limit: 255, null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cv_id"], name: "index_educations_on_cv_id"
  end

  create_table "experiences", force: :cascade do |t|
    t.bigint "cv_id", null: false
    t.date "started_on"
    t.date "ended_on"
    t.string "company", limit: 255, null: false
    t.string "location", limit: 255
    t.string "title", limit: 255, null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "website_url"
    t.index ["cv_id"], name: "index_experiences_on_cv_id"
  end

  create_table "languages", force: :cascade do |t|
    t.bigint "cv_id", null: false
    t.string "language", limit: 255, null: false
    t.string "level", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cv_id"], name: "index_languages_on_cv_id"
  end

  create_table "locations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.float "latitude"
    t.float "longitude"
    t.integer "radius"
    t.string "city", limit: 255
    t.string "country", limit: 255
    t.string "geocoded_address", limit: 255
    t.string "original_address", limit: 255, null: false
    t.string "province_code", limit: 255
    t.string "region", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_locations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", limit: 255, null: false
    t.string "last_name", limit: 255, null: false
    t.string "email", limit: 255, null: false
    t.string "encrypted_password", limit: 255, null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tel", limit: 255
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "subdomain"
    t.string "locale"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cvs", "users"
  add_foreign_key "educations", "cvs"
  add_foreign_key "experiences", "cvs"
  add_foreign_key "languages", "cvs"
  add_foreign_key "locations", "users"
end
