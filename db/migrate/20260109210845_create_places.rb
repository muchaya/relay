class CreatePlaces < ActiveRecord::Migration[8.0]
  def change
    create_table :places do |t|
      t.string :name
      t.string :slug
      t.string :locality
      t.string :province
      t.string :country, default: "Zimbabwe"

      t.timestamps
    end
  end
end
