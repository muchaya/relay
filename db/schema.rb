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

ActiveRecord::Schema[8.0].define(version: 2026_03_27_073008) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

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
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.string "status"
    t.decimal "base_price"
    t.decimal "commitment_fee"
    t.bigint "trip_id", null: false
    t.bigint "passenger_id", null: false
    t.datetime "cancelled_at"
    t.string "cancelled_by"
    t.integer "seats"
    t.string "payment_status"
    t.string "payment_reference"
    t.string "paid_at"
    t.boolean "no_show"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["passenger_id"], name: "index_bookings_on_passenger_id"
    t.index ["trip_id"], name: "index_bookings_on_trip_id"
  end

  create_table "places", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "locality"
    t.string "province"
    t.string "country", default: "Zimbabwe"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rideshares", force: :cascade do |t|
    t.integer "seat_capacity"
    t.boolean "women_only"
    t.string "luggage_policy"
    t.boolean "smoking_allowed"
    t.boolean "pets_allowed"
    t.text "driver_notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "routes", force: :cascade do |t|
    t.bigint "from_place_id"
    t.bigint "to_place_id"
    t.string "from_place_slug"
    t.string "to_place_slug"
    t.integer "distance_km"
    t.integer "time_minutes"
    t.integer "tollgates"
    t.string "status", default: "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_place_id"], name: "index_routes_on_from_place_id"
    t.index ["from_place_slug"], name: "index_routes_on_from_place_slug"
    t.index ["to_place_id"], name: "index_routes_on_to_place_id"
    t.index ["to_place_slug"], name: "index_routes_on_to_place_slug"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "trips", force: :cascade do |t|
    t.datetime "departure_time", null: false
    t.decimal "price", precision: 8, scale: 2, null: false
    t.integer "seat_capacity", null: false
    t.boolean "women_only", default: false, null: false
    t.boolean "instant_booking", default: false, null: false
    t.string "luggage_policy"
    t.boolean "smoking_allowed", default: false, null: false
    t.text "driver_notes"
    t.string "status", default: "active", null: false
    t.bigint "route_id", null: false
    t.bigint "driver_id", null: false
    t.bigint "vehicle_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["departure_time"], name: "index_trips_on_departure_time"
    t.index ["driver_id"], name: "index_trips_on_driver_id"
    t.index ["route_id"], name: "index_trips_on_route_id"
    t.index ["status"], name: "index_trips_on_status"
    t.index ["vehicle_id"], name: "index_trips_on_vehicle_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "fullname", null: false
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.string "phone_number"
    t.boolean "terms_accepted"
    t.boolean "privacy_policy_accepted"
    t.string "gender"
    t.string "identity_card_number"
    t.boolean "verified"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "model"
    t.string "color"
    t.string "number_plate"
    t.string "vehicle_type"
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_vehicles_on_owner_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookings", "trips"
  add_foreign_key "bookings", "users", column: "passenger_id"
  add_foreign_key "routes", "places", column: "from_place_id"
  add_foreign_key "routes", "places", column: "to_place_id"
  add_foreign_key "sessions", "users"
  add_foreign_key "trips", "routes"
  add_foreign_key "trips", "users", column: "driver_id"
  add_foreign_key "trips", "vehicles"
end
