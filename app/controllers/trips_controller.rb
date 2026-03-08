class TripsController < ApplicationController
  def show
    @trip = trip.find(params[:trip_id])
  end
end
