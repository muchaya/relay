class Booking::PaymentJob < ApplicationJob
  def perform(payment)
    result = Paynow::Payment.check(poll_url: payment.poll_url)

    case result.status
    when "Paid"
      payment.update!(status: :completed, paid_at: Time.zone.now)
      payment.booking.update!(status: :reserved)
    when "Failed"
      payment.update!(status: :failed)
    when "Cancelled"
      payment.update!(status: :failed)
    else
      self.class.set(wait: 1.second).perform_later(payment)
    end
  end
end
