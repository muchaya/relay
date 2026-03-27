class BookingsController < ApplicationController
  allow_unauthenticated_access

  def new
    @booking = Booking.new
  end

  def show
  end
end
