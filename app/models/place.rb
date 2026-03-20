class Place < ApplicationRecord
  has_many :departing_routes, class_name: "Route", foreign_key: :from_place_id
  has_many :arriving_routes, class_name: "Route", foreign_key: :to_place_id
  has_many :destinations, through: :departing_routes, source: :to_place

  before_validation :set_slug

  def icon
    icon_name = ICONS.fetch(name.parameterize.underscore.to_sym)

    "#{icon_name}.svg"
  end

  private
    ICONS = {
      beitbridge:      "bridge",
      bulawayo:        "city_v2",
      chiredzi:        "chiredzi",
      gweru:           "gweru",
      harare:          "city",
      kariba:          "kariba",
      masvingo:        "bricks",
      mutare:          "mountain",
      victoria_falls:  "tourist",
      zvishavane:      "building"
    }.freeze

    def set_slug
      self.slug = "#{name}".parameterize
    end
end
