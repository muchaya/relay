class CreateTrips < ActiveRecord::Migration[8.0]
  def change
    create_table :trips do |t|
      t.datetime :departure_time
      t.decimal :base_price
      t.string :status
      t.belongs_to :route, foreign_key: true

      t.timestamps
    end
  end
end
