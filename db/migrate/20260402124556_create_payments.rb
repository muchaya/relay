class CreatePayments < ActiveRecord::Migration[8.0]
  def change
    create_enum :payment_status, %w[ pending completed failed refunded ]

    create_table :payments do |t|
      t.enum :status, enum_type: 'payment_status'
      t.references :booking, null: false, foreign_key: true
      t.decimal :amount
      t.string :poll_url
      t.string :provider
      t.string :provider_reference
      t.datetime :paid_at

      t.timestamps
    end
  end
end
