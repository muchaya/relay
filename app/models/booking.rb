class Booking < ApplicationRecord
  belongs_to :trip
  belongs_to :passenger, class_name: "User"

  has_one :payment

  enum :status, %w[ pending reserved confirmed completed cancelled ].index_by(&:itself)
end
