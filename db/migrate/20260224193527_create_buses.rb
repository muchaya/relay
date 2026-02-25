class CreateBuses < ActiveRecord::Migration[8.0]
  def change
    create_table :buses do |t|
      t.integer :capacity
      t.string :luggage_policy
      t.text :operator_notes
      t.belongs_to :trip, foreign_key: true
      t.belongs_to :operator, foreign_key: true
      t.belongs_to :vehicle, foreign_key: true

      t.timestamps
    end
  end
end
