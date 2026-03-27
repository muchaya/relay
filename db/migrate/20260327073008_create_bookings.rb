class CreateBookings < ActiveRecord::Migration[8.0]
  def change
    create_table :bookings do |t|
      t.string :status
      t.decimal :base_price
      t.decimal :commitment_fee
      t.references :trip, null: false, foreign_key: true
      t.references :passenger, null: false, foreign_key: true, foreign_key: { to_table: :users }
      t.datetime :cancelled_at
      t.string :cancelled_by
      t.integer :seats
      t.string :payment_status
      t.string :payment_reference
      t.string :paid_at
      t.boolean :no_show

      t.timestamps
    end
  end
end
