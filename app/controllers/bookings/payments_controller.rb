class Bookings::PaymentsController < ApplicationController
  allow_unauthenticated_access
  layout "blank"

  def show
    @payment = Payment.find(params[:id])
    @trip = @payment.booking.trip
  end
end
