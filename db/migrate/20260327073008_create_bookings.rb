class CreateBookings < ActiveRecord::Migration[8.0]
  def change
    create_enum :booking_status, %w[ pending reserved confirmed completed cancelled ]

    create_table :bookings do |t|
      t.enum :status, enum_type: 'booking_status'
      t.decimal :commitment_fee
      t.references :trip, null: false, foreign_key: true
      t.references :passenger, null: false, foreign_key: true, foreign_key: { to_table: :users }
      t.string :phone_number
      t.string :payment_method
      t.datetime :cancelled_at
      t.string :cancelled_by
      t.integer :seats
      t.boolean :no_show, default: false

      t.timestamps
    end
  end
end
