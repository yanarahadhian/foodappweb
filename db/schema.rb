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

ActiveRecord::Schema.define(version: 20160210061305) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  limit: 255
    t.string   "full_name",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "cart_items", force: :cascade do |t|
    t.integer  "cart_id",    limit: 4
    t.integer  "item_id",    limit: 4
    t.string   "amount",     limit: 255
    t.decimal  "item_price",             precision: 10
    t.decimal  "sub_total",              precision: 10
    t.decimal  "vat_total",              precision: 10
    t.decimal  "total",                  precision: 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carts", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "is_paid",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "body",       limit: 65535
    t.integer  "item_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "comments", ["item_id"], name: "index_comments_on_item_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "code",       limit: 255
    t.string   "currency",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "custom_addresses", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "address",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "recipient",  limit: 255
    t.string   "name",       limit: 255
    t.string   "state",      limit: 255
    t.string   "city",       limit: 255
    t.string   "postal",     limit: 255
    t.string   "phone",      limit: 255
    t.boolean  "is_active"
  end

  add_index "custom_addresses", ["user_id"], name: "index_custom_addresses_on_user_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "followers", force: :cascade do |t|
    t.integer "user_id",          limit: 4
    t.integer "user_follower_id", limit: 4
  end

  create_table "follows", force: :cascade do |t|
    t.integer  "followable_id",   limit: 4,                   null: false
    t.string   "followable_type", limit: 255,                 null: false
    t.integer  "follower_id",     limit: 4,                   null: false
    t.string   "follower_type",   limit: 255,                 null: false
    t.boolean  "blocked",                     default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables", using: :btree
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows", using: :btree

  create_table "images", force: :cascade do |t|
    t.string   "storage",    limit: 255
    t.string   "flag",       limit: 255
    t.integer  "item_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "images", ["item_id"], name: "index_images_on_item_id", using: :btree
  add_index "images", ["user_id"], name: "index_images_on_user_id", using: :btree

  create_table "invitations", force: :cascade do |t|
    t.string   "first_name", limit: 255
    t.string   "email",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",     limit: 255
    t.text     "ref_id",     limit: 65535
    t.string   "username",   limit: 255
    t.integer  "inviter_id", limit: 4
    t.text     "notes",      limit: 65535
    t.string   "country",    limit: 255
  end

  add_index "invitations", ["username"], name: "index_invitations_on_username", unique: true, using: :btree

  create_table "item_categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_favourites", force: :cascade do |t|
    t.integer  "item_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "item_favourites", ["item_id"], name: "index_item_favourites_on_item_id", using: :btree
  add_index "item_favourites", ["user_id"], name: "index_item_favourites_on_user_id", using: :btree

  create_table "item_impressions", force: :cascade do |t|
    t.integer  "item_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "item_impressions", ["item_id"], name: "index_item_impressions_on_item_id", using: :btree
  add_index "item_impressions", ["user_id"], name: "index_item_impressions_on_user_id", using: :btree

  create_table "item_likes", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "item_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "item_likes", ["item_id"], name: "index_item_likes_on_item_id", using: :btree
  add_index "item_likes", ["user_id"], name: "index_item_likes_on_user_id", using: :btree

  create_table "item_photos", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "item_id",    limit: 4
    t.integer  "position",   limit: 4
    t.string   "url",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: :cascade do |t|
    t.integer  "user_id",          limit: 4
    t.integer  "item_category_id", limit: 4
    t.string   "name",             limit: 255
    t.float    "delivery_fee",     limit: 24
    t.float    "price",            limit: 24
    t.text     "description",      limit: 65535
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "like_count",       limit: 4,     default: 0
    t.string   "permalink",        limit: 255
    t.string   "status",           limit: 255
  end

  add_index "items", ["permalink"], name: "index_items_on_permalink", using: :btree

  create_table "items_orders", id: false, force: :cascade do |t|
    t.integer "item_id",  limit: 4
    t.integer "order_id", limit: 4
  end

  add_index "items_orders", ["item_id"], name: "index_items_orders_on_item_id", using: :btree
  add_index "items_orders", ["order_id"], name: "index_items_orders_on_order_id", using: :btree

  create_table "items_stores", id: false, force: :cascade do |t|
    t.integer "item_id",  limit: 4
    t.integer "store_id", limit: 4
  end

  add_index "items_stores", ["item_id"], name: "index_items_stores_on_item_id", using: :btree
  add_index "items_stores", ["store_id"], name: "index_items_stores_on_store_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.datetime "notif_date"
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.integer  "store_id",          limit: 4
    t.integer  "custom_address_id", limit: 4
    t.integer  "quantity",          limit: 4
    t.text     "description",       limit: 65535
    t.integer  "status",            limit: 4
    t.boolean  "is_deleted_seller"
    t.string   "verification_code", limit: 255
    t.float    "rating",            limit: 24
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "item_id",           limit: 4
    t.datetime "order_date"
    t.string   "order_id",          limit: 255
    t.text     "rating_string",     limit: 65535
    t.string   "payment_id",        limit: 255
    t.float    "subtotal",          limit: 24
    t.text     "reject_reason",     limit: 65535
  end

  add_index "orders", ["item_id"], name: "index_orders_on_item_id", using: :btree

  create_table "orders_payments", force: :cascade do |t|
    t.integer "order_id",   limit: 4
    t.integer "payment_id", limit: 4
  end

  add_index "orders_payments", ["order_id"], name: "index_orders_payments_on_order_id", using: :btree
  add_index "orders_payments", ["payment_id"], name: "index_orders_payments_on_payment_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer  "cart_id",         limit: 4
    t.integer  "user_id",         limit: 4
    t.integer  "number_of_items", limit: 4
    t.decimal  "sub_total",                     precision: 10
    t.decimal  "vat_total",                     precision: 10
    t.decimal  "total",                         precision: 10
    t.date     "payment_date"
    t.string   "status",          limit: 255
    t.integer  "reference_id",    limit: 4
    t.string   "currency",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "stripe",          limit: 65535
    t.string   "transaction_id",  limit: 255
    t.text     "message",         limit: 65535
  end

  create_table "quick_bloxes", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "qb_id",       limit: 4
    t.string   "qb_username", limit: 255
    t.string   "qb_password", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "quick_bloxes", ["user_id"], name: "index_quick_bloxes_on_user_id", using: :btree

  create_table "redeem_requests", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.decimal  "amount",               precision: 10
    t.integer  "status",     limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "redeem_requests", ["user_id"], name: "index_redeem_requests_on_user_id", using: :btree

  create_table "report_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "reports", force: :cascade do |t|
    t.integer  "report_type_id",   limit: 4
    t.string   "comment",          limit: 255
    t.integer  "report_id",        limit: 4
    t.string   "report_type",      limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "reporter_integer", limit: 255
    t.string   "reason",           limit: 255
  end

  add_index "reports", ["report_type", "report_id"], name: "index_reports_on_report_type_and_report_id", using: :btree
  add_index "reports", ["report_type_id"], name: "index_reports_on_report_type_id", using: :btree

  create_table "stores", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "country",    limit: 255
    t.string   "city",       limit: 255
    t.string   "street",     limit: 255
    t.string   "location",   limit: 255
    t.string   "phone",      limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.float    "latitude",   limit: 24
    t.float    "longitude",  limit: 24
  end

  add_index "stores", ["user_id"], name: "index_stores_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "full_name",              limit: 255
    t.string   "email",                  limit: 255
    t.string   "password_digest",        limit: 255
    t.string   "access_token",           limit: 255
    t.datetime "token_generated_at"
    t.text     "settings",               limit: 65535
    t.string   "facebook_id",            limit: 255
    t.boolean  "verified_fb"
    t.string   "country",                limit: 255
    t.string   "city",                   limit: 255
    t.string   "website_url",            limit: 255
    t.text     "about_me",               limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "google_id",              limit: 255
    t.boolean  "verified_gplus"
    t.string   "phone",                  limit: 255
    t.string   "permalink",              limit: 255
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.text     "reset_password_digest",  limit: 65535
    t.datetime "reset_password_expiry"
    t.string   "username",               limit: 255
    t.string   "status",                 limit: 255
    t.string   "redeem_token",           limit: 255
    t.datetime "redeem_token_expire"
    t.string   "bank_account",           limit: 255
    t.string   "bank_account_number",    limit: 255
  end

  add_index "users", ["access_token"], name: "index_users_on_access_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["permalink"], name: "index_users_on_permalink", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "wallet_transactions", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.decimal  "amount",                        precision: 10
    t.string   "description",       limit: 255
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.boolean  "is_holded"
    t.integer  "redeem_request_id", limit: 4
  end

  add_index "wallet_transactions", ["redeem_request_id"], name: "index_wallet_transactions_on_redeem_request_id", using: :btree
  add_index "wallet_transactions", ["user_id"], name: "index_wallet_transactions_on_user_id", using: :btree

  add_foreign_key "comments", "items"
  add_foreign_key "comments", "users"
  add_foreign_key "custom_addresses", "users"
  add_foreign_key "images", "items"
  add_foreign_key "images", "users"
  add_foreign_key "item_favourites", "items"
  add_foreign_key "item_favourites", "users"
  add_foreign_key "item_impressions", "items"
  add_foreign_key "item_impressions", "users"
  add_foreign_key "item_likes", "items"
  add_foreign_key "item_likes", "users"
  add_foreign_key "items_stores", "items"
  add_foreign_key "items_stores", "stores"
  add_foreign_key "orders_payments", "orders"
  add_foreign_key "orders_payments", "payments"
  add_foreign_key "quick_bloxes", "users"
  add_foreign_key "redeem_requests", "users"
  add_foreign_key "reports", "report_types"
  add_foreign_key "stores", "users"
  add_foreign_key "wallet_transactions", "redeem_requests"
  add_foreign_key "wallet_transactions", "users"
end
