class TripsController < ApplicationController
  allow_unauthenticated_access

  def show
    @trip = Trip.find(params[:id])
  end
end
