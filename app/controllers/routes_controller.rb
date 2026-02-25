class RoutesController < ApplicationController
  allow_unauthenticated_access

  def index
    @from_place = Place.find_by(name: params[:from])
    @to_place = Place.find_by(name: params[:to])
    
    from_place_id = @from_place.id
    to_place_id = @to_place.id

    @route = Route.find_by(from_place_id: from_place_id, to_place_id: to_place_id)
  end
end
