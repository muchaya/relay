class CreateVehicles < ActiveRecord::Migration[8.0]
  def change
    create_table :vehicles do |t|
      t.string :make
      t.string :model
      t.string :color
      t.string :number_plate
      t.boolean :terms_accepted
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
