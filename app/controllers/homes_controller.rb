class HomesController < ApplicationController
  allow_unauthenticated_access

  def show
   @routes_graph = Route.network.to_json
  end
end
