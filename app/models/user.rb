class User < ApplicationRecord
  ECONET_NETONE_PHONE_NUMBER_REGEX = /\A07[178]\d{7}\z/

  has_secure_password

  has_one_attached :avatar
  has_many :sessions, dependent: :destroy
  has_many :bookings, foreign_key: :passenger_id, dependent: :destroy
  has_many :trips, through: :bookings
  has_many :vehicles

  #has_many :ride_shares, foreign_key: :driver_id, dependent: :destroy
  #has_many :driven_trips, through: :ride_shares, source: :trip

  #has_many :vehicles, foreign_key: :owner_id, dependent: :nullify

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  normalizes :phone_number, with: -> (pn) { pn.gsub(/\s+/, "") }

  validates :phone_number, presence: true, uniqueness: true, format: { with: ECONET_NETONE_PHONE_NUMBER_REGEX, message: "must be a valid 10-digit NetOne or Econet number (e.g., 0772123456)" }
  validates :email_address, uniqueness: { case_sensitive: false }, presence: true
  validates :password, length: { in: 8..72 }

  scope :verified_drivers, -> { where(verified: true) }
end
