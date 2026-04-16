class Booking < ApplicationRecord
  belongs_to :trip
  belongs_to :passenger, class_name: "User"

  has_one :payment

  enum :status, %w[ pending reserved confirmed completed cancelled ].index_by(&:itself)

  validate :check_seat_availability

  def total_price
    base_price + commitment_fee
  end

  def total_commitment_fee
    commitment_fee * seats
  end

  private
    def check_seat_availability
      if seats > trip.seat_capacity
        errors.add(:seats, :too_many, message: "Only #{trip.available_seats} seat#{'s' if trip.available_seats != 1} left.")
      end
    end
end
