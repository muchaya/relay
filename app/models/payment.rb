class Payment < ApplicationRecord
  include Turbo::Broadcastable
  belongs_to :booking

  enum :status, %w[ pending completed failed refunded ].index_by(&:itself)

  after_update_commit :broadcast_status_update

  private
    def broadcast_status_update
      case status
      when "completed"
        broadcast_replace_to(
          self,
          target: "payment_status_container",
          partial: "bookings/payments/confirmed",
          locals: { payment: self, trip: self.booking.trip }
        )
      when "failed"
        broadcast_replace_to(
          self,
          target: "payment_status_container",
          partial: "bookings/payments/failed",
          locals: { payment: self }
        )
      end
    end
end
