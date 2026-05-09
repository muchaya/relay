class Account::TripsController < ApplicationController
  layout "account"

  def index
    @trips = Current.user.trips
  end
end
