class RoutesController < ApplicationController
  allow_unauthenticated_access

  def index
    @from_place = Place.find_by(name: params[:from])
    @to_place = Place.find_by(name: params[:to])
    
    from_place_id = @from_place.id
    to_place_id = @to_place.id

    @route = Route.find_by(from_place_id: from_place_id, to_place_id: to_place_id)
    
    @date = Date.parse(params[:date]) || Date.today

    @trips = @route.trips.on(@date).order(sort).filter_by(params)
  end

  private
    def sort
      params[:sort].presence_in(%w[departure_time price]) || "departure_time"
    end
end
