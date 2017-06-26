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

ActiveRecord::Schema.define(version: 20170626155234) do

  create_table "accommodations", force: :cascade do |t|
    t.string   "location"
    t.string   "room_type"
    t.decimal  "price"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "view"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "views",          default: 0
    t.integer  "tot_likes"
    t.integer  "price_to"
    t.integer  "price_from"
    t.string   "institution"
    t.integer  "transaction_id"
    t.boolean  "is_secured"
    t.string   "slug"
    t.integer  "house_id"
    t.index ["slug"], name: "index_accommodations_on_slug", unique: true
  end

  create_table "attend_events", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.integer  "category_id"
    t.decimal  "price"
    t.text     "description"
    t.string   "author"
    t.integer  "user_id"
    t.integer  "institution_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "picture_id"
    t.string   "slug"
    t.index ["slug"], name: "index_books_on_slug", unique: true
  end

  create_table "books_time_slots", force: :cascade do |t|
    t.string "time"
  end

  create_table "books_transactions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "buyer_id"
    t.boolean  "sold",       default: false
    t.boolean  "in_trans",   default: false
    t.string   "time"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "book_id"
    t.string   "day"
  end

  create_table "categories", force: :cascade do |t|
    t.integer  "item_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "book_type"
    t.integer  "book_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "com"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "post_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string   "question"
    t.string   "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "houses", force: :cascade do |t|
    t.string   "address"
    t.string   "wifi"
    t.integer  "user_id"
    t.boolean  "nsfas"
    t.string   "common"
    t.boolean  "prepaid_elec"
    t.integer  "accommodation_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "location"
    t.string   "city"
    t.string   "string"
    t.string   "nearto_id"
    t.string   "country"
  end

  create_table "institutions", force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "book_id"
  end

  create_table "items", force: :cascade do |t|
    t.decimal  "price"
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.text     "description"
    t.integer  "picture_id"
    t.integer  "category_id"
    t.integer  "views",       default: 0
    t.integer  "tot_likes",   default: 0
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "post_id"
  end

  create_table "near_tos", force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "house_id"
  end

  create_table "network_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_network_categories_on_name", unique: true
  end

  create_table "networks", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "user_id"
    t.integer  "network_category_id"
    t.         "desc"
    t.integer  "network_type"
    t.string   "handle"
    t.index ["name"], name: "index_networks_on_name", unique: true
  end

  create_table "pictures", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "item_id"
    t.integer  "book_id"
    t.integer  "accommodation_id"
    t.integer  "post_id"
    t.integer  "house_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "views"
    t.integer  "likes",       default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "network_id"
    t.integer  "user_id"
    t.boolean  "is_event",    default: false
    t.index ["name"], name: "index_posts_on_name", unique: true
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "handle"
    t.string   "name"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "instergram"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.string   "profile_img_file_name"
    t.string   "profile_img_content_type"
    t.integer  "profile_img_file_size"
    t.datetime "profile_img_updated_at"
    t.integer  "user_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "network_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "network_id"], name: "index_subscriptions_on_user_id_and_network_id"
  end

  create_table "time_slots", force: :cascade do |t|
    t.string   "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "time_slots_users", id: false, force: :cascade do |t|
    t.integer "user_id",      null: false
    t.integer "time_slot_id", null: false
    t.index ["time_slot_id", "user_id"], name: "index_time_slots_users_on_time_slot_id_and_user_id"
    t.index ["user_id", "time_slot_id"], name: "index_time_slots_users_on_user_id_and_time_slot_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "accomodation_id"
    t.boolean  "paid"
    t.boolean  "booking_type"
    t.boolean  "std_confirm"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "host_id"
    t.string   "month"
    t.string   "time"
    t.text     "message"
    t.boolean  "go_ahead"
    t.integer  "runner_id"
  end

  create_table "user_accommodation_shares", force: :cascade do |t|
    t.string   "user_token"
    t.integer  "accom_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                    default: "", null: false
    t.string   "encrypted_password",       default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",            default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "profile_id"
    t.string   "password_salt"
    t.string   "password_confirmation"
    t.string   "password"
    t.string   "password_hash"
    t.integer  "item_id"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.string   "profile_img_file_name"
    t.string   "profile_img_content_type"
    t.integer  "profile_img_file_size"
    t.datetime "profile_img_updated_at"
    t.text     "about"
    t.string   "contacts"
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.boolean  "host"
    t.boolean  "verified"
    t.string   "ip"
    t.text     "bank_details"
    t.string   "token"
    t.boolean  "runner"
    t.string   "time_slots"
    t.string   "run_location"
    t.boolean  "king"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
