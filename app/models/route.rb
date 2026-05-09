class Route < ApplicationRecord
  belongs_to :from_place, class_name: "Place"
  belongs_to :to_place, class_name: "Place"

  has_many :trips

  scope :active, -> { where(status: :active)}
  scope :from_place, ->(place_id) { where(from_place_id: place_id) }

  before_save :set_slugs

  def self.network
    {
      places: Place.all.map { |p| { id: p.id, slug: p.slug, name: p.name, locality: p.locality, province: p.province } },
      routes: Route.includes(:from_place, :to_place).where(status: "active").map do |r|
        { from: r.from_place_id, to: r.to_place_id, distance_km: r.distance_km }
      end
    }
  end

  def self.destinations_from(place_id)
    where(from_place_id: place_id)
  end

  private
    def set_slugs
      self.from_place_slug = from_place.slug 
      self.to_place_slug = to_place.slug
    end
end
