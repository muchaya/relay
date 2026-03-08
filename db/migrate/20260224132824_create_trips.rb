class CreateTrips < ActiveRecord::Migration[8.0]
  def change
    create_table :trips do |t|
      t.datetime :departure_time, null: false
      t.decimal  :price, precision: 8, scale: 2, null: false
      t.integer :seat_capacity, null: false
      t.boolean :women_only, default: false, null: false
      t.boolean :instant_booking, default: false, null: false
      t.string  :luggage_policy
      t.boolean :smoking_allowed, default: false, null: false
      t.text :driver_notes
      t.string :status, default: "active", null: false

      t.references :route,  null: false, foreign_key: true
      t.references :driver, null: false, foreign_key: { to_table: :users }
      t.references :vehicle, null: false, foreign_key: true

      t.timestamps
    end

    add_index :trips, :departure_time
    add_index :trips, :status
  end
end