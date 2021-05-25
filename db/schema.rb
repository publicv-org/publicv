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

ActiveRecord::Schema.define(version: 2021_05_20_081805) do

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
    t.text "about"
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
    t.boolean "custom_experience_sort", default: false
    t.boolean "custom_education_sort", default: false
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
    t.integer "position", default: 0
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
    t.integer "position", default: 0
    t.index ["cv_id"], name: "index_experiences_on_cv_id"
  end

  create_table "geonames", force: :cascade do |t|
    t.integer "geonameid"
    t.string "name", limit: 200
    t.string "asciiname", limit: 200
    t.text "alternatenames"
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.string "feature_class", limit: 1
    t.string "feature_code", limit: 10
    t.string "country_code", limit: 2
    t.string "cc2", limit: 200
    t.string "admin1_code", limit: 20
    t.string "admin2_code", limit: 80
    t.string "admin3_code", limit: 20
    t.string "admin4_code", limit: 20
    t.bigint "population"
    t.integer "elevation"
    t.integer "dem"
    t.string "timezone", limit: 40
    t.datetime "modification_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.integer "geoname_id"
    t.index ["user_id"], name: "index_locations_on_user_id"
  end

  create_table "newsletters", force: :cascade do |t|
    t.string "name"
    t.string "subject"
    t.text "content"
    t.string "recipient_ids"
    t.datetime "sent_at"
    t.string "slug"
    t.string "preference_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "searches", force: :cascade do |t|
    t.string "query"
    t.string "slug"
    t.string "locale", default: "en", null: false
    t.integer "views", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["query", "locale"], name: "index_searches_on_query_and_locale"
    t.index ["query"], name: "index_searches_on_query", unique: true
    t.index ["slug"], name: "index_searches_on_slug", unique: true
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
    t.boolean "admin"
    t.boolean "online_updates"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cvs", "users"
  add_foreign_key "educations", "cvs"
  add_foreign_key "experiences", "cvs"
  add_foreign_key "languages", "cvs"
  add_foreign_key "locations", "users"
end
