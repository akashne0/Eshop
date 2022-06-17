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

ActiveRecord::Schema.define(version: 2022_06_17_115710) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.integer "user_id"
    t.string "address_1"
    t.string "address_2"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "zipcode"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "banner_images", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "subtotal"
    t.decimal "total"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "parent_id"
    t.integer "created_by"
    t.date "created_date"
    t.integer "modify_by"
    t.date "modify_date"
    t.boolean "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "configurations", force: :cascade do |t|
    t.string "conf_key"
    t.string "conf_value"
    t.integer "created_by"
    t.date "created_date"
    t.integer "modify_by"
    t.date "modify_date"
    t.boolean "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "contact_us", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "contact_no"
    t.text "message"
    t.text "admin_note"
    t.integer "created_by"
    t.date "created_date"
    t.integer "modify_by"
    t.date "modify_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "contact_no"
    t.text "message"
    t.text "admin_note"
    t.integer "created_by"
    t.date "created_date"
    t.integer "modify_by"
    t.date "modify_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "coupon_useds", force: :cascade do |t|
    t.integer "user_id"
    t.integer "coupon_id"
    t.integer "order_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "coupons", force: :cascade do |t|
    t.string "code"
    t.float "percent_off"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "status"
  end

  create_table "line_items", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "cart_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "quantity", default: 1
    t.decimal "total"
    t.decimal "unit_price"
    t.integer "order_id"
    t.index ["cart_id"], name: "index_line_items_on_cart_id"
    t.index ["product_id"], name: "index_line_items_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "address_id"
    t.integer "total"
    t.string "pay_type"
    t.integer "status", default: 0
    t.bigint "coupon_id"
    t.bigint "user_id"
    t.index ["coupon_id"], name: "index_orders_on_coupon_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "product_attributes_assocs", force: :cascade do |t|
  end

  create_table "product_categories", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_product_categories_on_category_id"
    t.index ["product_id"], name: "index_product_categories_on_product_id"
  end

  create_table "product_images", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.string "image_name"
    t.boolean "status"
    t.integer "created_by"
    t.date "created_date"
    t.integer "modify_by"
    t.date "modify_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_product_images_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "sku"
    t.string "short_description"
    t.text "long_description"
    t.float "price"
    t.float "special_price"
    t.date "special_price_from"
    t.date "special_price_to"
    t.boolean "status"
    t.integer "quantity"
    t.string "meta_title"
    t.text "meta_description"
    t.text "meta_keywords"
    t.integer "created_by"
    t.date "created_date"
    t.integer "modify_by"
    t.date "modify_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "stripe_product_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: ""
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "provider", limit: 50, default: "", null: false
    t.string "uid", limit: 50, default: "", null: false
    t.boolean "admin", default: false
    t.string "stripe_customer_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wishlists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "product_id", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_wishlists_on_product_id"
    t.index ["user_id"], name: "index_wishlists_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "line_items", "carts"
  add_foreign_key "line_items", "products"
  add_foreign_key "orders", "coupons"
  add_foreign_key "orders", "users"
  add_foreign_key "product_categories", "categories"
  add_foreign_key "product_categories", "products"
  add_foreign_key "product_images", "products"
  add_foreign_key "wishlists", "users"
end
