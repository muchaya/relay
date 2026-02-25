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

ActiveRecord::Schema[8.0].define(version: 2026_02_24_193527) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "buses", force: :cascade do |t|
    t.integer "capacity"
    t.string "luggage_policy"
    t.text "operator_notes"
    t.bigint "trip_id"
    t.bigint "operator_id"
    t.bigint "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["operator_id"], name: "index_buses_on_operator_id"
    t.index ["trip_id"], name: "index_buses_on_trip_id"
    t.index ["vehicle_id"], name: "index_buses_on_vehicle_id"
  end

  create_table "operators", force: :cascade do |t|
    t.string "name"
    t.string "phone_number"
    t.string "email"
    t.string "verified"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.integer "minutes_by_bus"
    t.integer "minutes_by_rideshare"
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
    t.datetime "departure_time"
    t.decimal "base_price"
    t.string "status"
    t.bigint "route_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["route_id"], name: "index_trips_on_route_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name", null: false
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.string "phone_number"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "buses", "operators"
  add_foreign_key "buses", "trips"
  add_foreign_key "buses", "vehicles"
  add_foreign_key "routes", "places", column: "from_place_id"
  add_foreign_key "routes", "places", column: "to_place_id"
  add_foreign_key "sessions", "users"
  add_foreign_key "trips", "routes"
end
