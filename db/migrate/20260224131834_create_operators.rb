class CreateOperators < ActiveRecord::Migration[8.0]
  def change
    create_table :operators do |t|
      t.string :name
      t.string :phone_number
      t.string :email
      t.string :verified

      t.timestamps
    end
  end
end
