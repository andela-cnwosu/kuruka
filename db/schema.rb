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

ActiveRecord::Schema.define(version: 20160931172519) do

  create_table "aircrafts", force: :cascade do |t|
    t.string   "tail_number"
    t.integer  "economy_capacity"
    t.integer  "business_capacity"
    t.integer  "first_capacity"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "airfares", force: :cascade do |t|
    t.decimal  "service_charge_in_dollar"
    t.integer  "route_id"
    t.integer  "travel_class_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["route_id"], name: "index_airfares_on_route_id"
    t.index ["travel_class_id"], name: "index_airfares_on_travel_class_id"
  end

  create_table "airports", force: :cascade do |t|
    t.string   "name"
    t.string   "city"
    t.string   "iata_code"
    t.integer  "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_airports_on_state_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.string   "booking_ref"
    t.decimal  "cost_in_dollar"
    t.string   "passenger_email"
    t.integer  "user_id"
    t.integer  "flight_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["flight_id"], name: "index_bookings_on_flight_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.string   "country_code"
    t.string   "currency"
    t.string   "iso_currency"
    t.string   "exchange_rate"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "flights", force: :cascade do |t|
    t.datetime "departure_date"
    t.datetime "arrival_date"
    t.integer  "aircraft_id"
    t.integer  "route_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["aircraft_id"], name: "index_flights_on_aircraft_id"
    t.index ["route_id"], name: "index_flights_on_route_id"
  end

  create_table "passengers", force: :cascade do |t|
    t.string   "first_name",  limit: 30
    t.string   "last_name",   limit: 30
    t.string   "phone",       limit: 16
    t.string   "passport_no", limit: 15
    t.boolean  "checked_in",             default: false
    t.integer  "user_id"
    t.integer  "airfare_id"
    t.integer  "booking_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["airfare_id"], name: "index_passengers_on_airfare_id"
    t.index ["booking_id"], name: "index_passengers_on_booking_id"
    t.index ["user_id"], name: "index_passengers_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "booking_id"
    t.datetime "payment_date"
    t.string   "transaction_ref"
    t.integer  "status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["booking_id"], name: "index_payments_on_booking_id"
  end

  create_table "routes", force: :cascade do |t|
    t.string   "name"
    t.integer  "departure_airport_id"
    t.integer  "arrival_airport_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["arrival_airport_id"], name: "index_routes_on_arrival_airport_id"
    t.index ["departure_airport_id"], name: "index_routes_on_departure_airport_id"
  end

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_states_on_country_id"
  end

  create_table "travel_classes", force: :cascade do |t|
    t.string   "name"
    t.decimal  "tax_percent"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",          limit: 30
    t.string   "last_name",           limit: 30
    t.string   "email"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_digest"], name: "index_users_on_remember_digest"
  end

end
