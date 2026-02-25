class CreateVehicles < ActiveRecord::Migration[8.0]
  def change
    create_table :vehicles do |t|
      t.string :model
      t.string :color
      t.string :number_plate
      t.string :vehicle_type

      t.timestamps
    end
  end
end
