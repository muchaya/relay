class BookingsController < ApplicationController
  allow_unauthenticated_access

  def new
    @booking = Booking.new
    @trip = Trip.find(params[:trip_id])
  end

  def show
  end
end
