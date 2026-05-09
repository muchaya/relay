class VehiclesController < ApplicationController
  layout "account", only: [:index]

  def index
    @vehicles = Current.user.vehicles
  end

  def new
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Current.user.vehicles.create!(vehicle_params)

    respond_to do |format|
      format.turbo_stream
    end
  end

  private
    def vehicle_params
      params.expect(vehicle: [ :make, :model, :color, :number_plate, :seats, :terms_accepted, :user_id])
    end
end
