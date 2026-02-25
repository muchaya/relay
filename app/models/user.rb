class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :bookings, foreign_key: :passenger_id, dependent: :destroy
  has_many :trips, through: :bookings

  has_many :ride_shares, foreign_key: :driver_id, dependent: :destroy
  has_many :driven_trips, through: :ride_shares, source: :trip

  has_many :vehicles, foreign_key: :owner_id, dependent: :nullify


  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
