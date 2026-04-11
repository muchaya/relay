class BookingsController < ApplicationController
  allow_unauthenticated_access

  def create
    @booking = Booking.create!(booking_params.merge(status: Booking.statuses[:pending]))

    payment = Paynow::Payment.create(
      amount: @booking.commitment_fee,
      reference: @booking.id,
      method: booking_params[:payment_method],
      phone_number: booking_params[:phone_number],
      auth_email: "iblessing@outlook.com"
    )

    if payment.success?
      @payment = @booking.create_payment(status: Payment.statuses[:pending], amount: payment.amount, poll_url: payment.poll_url, provider: payment.method, provider_reference: payment.paynow_reference)

      Booking::PaymentJob.perform_later(@payment)

      redirect_to booking_payment_path(@booking, @payment)
    end
  end
  
  def new
    @booking = Booking.new
    @trip = Trip.find(params[:trip_id])
  end

  def show
  end

  def booking_params
    params.expect(booking: [ :base_price, :commitment_fee, :trip_id, :passenger_id, :seats, :phone_number, :payment_method ])
  end
end
