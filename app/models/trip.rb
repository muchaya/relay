class Trip < ApplicationRecord
  belongs_to :route
  has_many :bookings, dependent: :destroy

  delegated_type :tripable, types: %w[Rideshare Bus]

  def arrival_time
  end
end
