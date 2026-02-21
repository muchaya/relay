class Route < ApplicationRecord
  belongs_to :from_place, class_name: "Place"
  belongs_to :to_place, class_name: "Place"


  def self.network
    {
      places: Place.all.map { |p| { id: p.id, name: p.name, locality: p.locality, province: p.province } },
      routes: Route.includes(:from_place, :to_place).where(status: "active").map do |r|
        { from: r.from_place_id, to: r.to_place_id, distance_km: r.distance_km }
      end
    }
  end
end
