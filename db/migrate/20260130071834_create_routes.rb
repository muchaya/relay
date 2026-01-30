class CreateRoutes < ActiveRecord::Migration[8.0]
  def change
    create_table :routes do |t|
      t.string :from_city
      t.string :to_city
      t.integer :distance_km
      t.string :status, default: "active"

      t.timestamps
    end
  end
end
