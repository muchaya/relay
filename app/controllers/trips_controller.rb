class TripsController < ApplicationController
  allow_unauthenticated_access only: :show

  def new
    if session[:trip_id].nil?
      @trip = Trip.new(driver_id: Current.user.id, status: Trip.statuses[:upcoming], wizard_complete: false)

      @trip.save! validate: false
      session[:trip_id] = @trip.id
    end

    redirect_to build_trip_path(Trip.form_steps.keys.first)
  end

  def show
    @trip = Trip.find(params[:id])
  end
end
