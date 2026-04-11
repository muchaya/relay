class DaysController < ApplicationController
  allow_unauthenticated_access

  def show
    @route = Route.find(params[:route_id])
    @day = Date.parse(params[:date]) || Date.current

    @trips = Trip
      .where(route: @route)
      .where(departure_time: @day.beginning_of_day..@day.end_of_day)
      .order(sort)
  end

  private
    def sort
      params[:sort].presence_in(%w[departure_time base_price]) || "departure_time"
    end
end
