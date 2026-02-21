class CreateRoutes < ActiveRecord::Migration[8.0]
  def change
    create_table :routes do |t|
      t.references :from_place, foreign_key: { to_table: :places }
      t.references :to_place, foreign_key: { to_table: :places }
      t.integer :distance_km
      t.string :status, default: "active"

      t.timestamps
    end
  end
end
