class Place < ApplicationRecord
  has_many :departing_routes, class_name: "Route", foreign_key: :from_place_id
  has_many :arriving_routes, class_name: "Route", foreign_key: :to_place_id
  has_many :destinations, through: :departing_routes, source: :to_place

  before_validation :set_slug

  private
    def set_slug
      self.slug = "#{name}-#{country}".parameterize
    end
end
