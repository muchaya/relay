class CreateTrips < ActiveRecord::Migration[8.0]
  def change
    create_enum :trip_status, %w[ upcoming full completed cancelled ]

    create_table :trips do |t|
      t.enum :status, enum_type: 'trip_status', default: "upcoming"
      t.datetime :departure_time
      t.decimal  :base_price, precision: 8, scale: 2
      t.decimal :commitment_fee, precision: 8, scale: 2
      t.integer :seat_capacity
      t.boolean :women_only, default: false
      t.boolean :instant_booking, default: false
      t.string  :luggage_policy
      t.boolean :smoking_allowed, default: false
      t.boolean :wizard_complete, default: "false"
      t.integer :from_place_id
      t.integer :to_place_id

      t.references :route, foreign_key: true
      t.references :driver, foreign_key: { to_table: :users }
      t.references :vehicle, foreign_key: true

      t.timestamps
    end

    add_index :trips, :departure_time
    add_index :trips, :status
  end
end
