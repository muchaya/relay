class FormSteps::TripStepsController < ApplicationController
  include Wicked::Wizard
  layout "blank"

  steps *Trip.form_steps.keys

  def show
    @trip = Trip.incomplete_wizard.find session[:trip_id]

    render_wizard
  end

  def update
    @trip = Trip.incomplete_wizard.find session[:trip_id]

    @trip.assign_attributes trip_params

    respond_to do |format|
      if @trip.valid?
        format.html { render_wizard(@trip) }
      else
        puts @trip.errors.first.message
        format.turbo_stream
      end
    end
  end

  private
    def trip_params
      params.expect(trip: [:from_place_id, :to_place_id, :departure_time, :base_price, :seat_capacity, :women_only, :luggage_policy, :smoking_allowed, :route_id])
    end

    def set_trip
      @trip = Trip.incomplete_wizard.find session[:trip_id]
    end

    def finish_wizard_path
      @trip.update!(wizard_complete: true)
  
      reset_wizard_session!
  
      flash[:notice] = "Trip successfully created"

      root_path
    end

    def reset_wizard_session!
      session.delete(:trip_from_id)
      session.delete(:trip_to_id)
      session.delete(:trip_id)
    end
end
