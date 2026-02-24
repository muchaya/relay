class Route < ApplicationRecord
  belongs_to :from_place, class_name: "Place"
  belongs_to :to_place, class_name: "Place"

  before_save :set_slugs

  def self.network
    {
      places: Place.all.map { |p| { id: p.id, slug: p.slug, name: p.name, locality: p.locality, province: p.province } },
      routes: Route.includes(:from_place, :to_place).where(status: "active").map do |r|
        { from: r.from_place_id, to: r.to_place_id, distance_km: r.distance_km }
      end
    }
  end

  private
    def set_slugs
      self.from_place_slug = from_place.slug 
      self.to_place_slug = to_place.slug
    end
end
