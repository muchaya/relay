class HomesController < ApplicationController
  def show
   @routes_graph = Route.network.to_json
  end
end
