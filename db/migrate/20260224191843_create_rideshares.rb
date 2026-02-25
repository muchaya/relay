class CreateRideshares < ActiveRecord::Migration[8.0]
  def change
    create_table :rideshares do |t|
      t.integer :seat_capacity
      t.boolean :women_only
      t.string :luggage_policy
      t.boolean :smoking_allowed
      t.boolean :pets_allowed
      t.text :driver_notes

      t.timestamps
    end
  end
end
