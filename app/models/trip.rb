class Trip < ApplicationRecord
  BOOLEAN_FILTERS = %i[women_only instant_booking].freeze
  COMMITMENT_FEE = 0.50

  belongs_to :route
  belongs_to :driver, class_name: "User"
  belongs_to :vehicle

  has_many :bookings, dependent: :destroy

  validates :departure_time, :base_price, :seat_capacity, presence: true
  validates :seat_capacity, numericality: { greater_than: 0 }
  validates :base_price, numericality: { greater_than_or_equal_to: 0 }

  scope :on, ->(day) { where(departure_time: day.beginning_of_day..day.end_of_day) }
  scope :women_only,    -> { where(women_only: true) }
  scope :instant_booking, -> { where(instant_booking: true) }
  scope :verified_drivers, -> { joins(:driver).merge(User.verified_drivers) }

  scope :filter_by, ->(params) {
    trips = all
    trips = trips.women_only      if params[:women_only]
    trips = trips.instant_booking if params[:instant_booking]
    trips = trips.verified_drivers if params[:verified_drivers]
    trips
  }

  def create_booking!(booking_params)
    transaction do
      with_lock do
        booking = bookings.build booking_params.merge(status: Booking.statuses[:pending])

        unless booking.valid?
          raise ActiveRecord::RecordInvalid, booking
        end

        booking.save!
        booking
      end
    end
  end

  def full?
    available_seats.zero?
  end

  def already_departed?
    departure_time.past?
  end

  def total_price_for(number_of_seats)
    number_of_seats * (base_price + COMMITMENT_FEE)
  end

  def commitment_fee_for(number_of_seats)
    number_of_seats * COMMITMENT_FEE
  end

  def seat_options
    (1..available_seats).map do |count|
      {
        value: count,
        label: "#{count} #{'seat'.pluralize(count)}",
        amount: total_price_for(count)
      }
    end
  end

  def available_seats_in_words
    case available_seats
    when 0 then "Full"
    when 1 then "1 seat left"
    else "#{available_seats} seats left"
    end
  end

  def available_seats
    seat_capacity - bookings.where(status: Booking.statuses[:reserved]).sum(:seats)
  end

  def departs_on
    departure_time.strftime("%a, %d %B %Y")
  end

  def departs_at
    departure_time.strftime("%H:%M")
  end

  def arrives_at
    (Time.zone.parse(departs_at) + duration.minutes).strftime("%H:%M")
  end

  def duration_in_hours
    "#{duration / 60}h#{duration % 60}"
  end

  def arrival_time
    route.time_minutes
  end

  def theme 
    night_trip? ? NIGHT_THEME : DAY_THEME
  end

  def seats_left
    #seat_capacity - bookings.confirmed.count
  end

  private
    DAY_THEME = {
      bg_color_class: "bg-blue/5",
      border_color_class: "border-[#d3d3d3]",
      divider_class: "border-[#d3d3d3]",
      heading_color_class: "text-slate-800/90", 
      icon: "sun.svg",
      icon_stroke_class: "stroke-gray-neutral",
      icon_text_class: "text-gray-neutral",
      icon_classes: "w-4 h-4 stroke-4 block mx-auto mr-2",
      image_ring_color_class: "border-blue",
      itinerary_classes: "itinerary-line",
      text_color: "gray-neutral",
      women_only_icon: "butterfly.svg"
    }.freeze

    NIGHT_THEME = {
      bg_color_class: "bg-[#323055]",
      border_color_class: "border-slate-800",
      heading_color_class: "text-zinc-300",
      divider_class: "border-black",
      icon: "moon.svg",
      icon_stroke_class: "stroke-zinc-400",
      icon_text_class: "text-zinc-400",
      icon_classes: "w-4 stroke-yellow-600 fill-yellow-600 mr-2",
      image_ring_color_class: "border-zinc-500",      
      itinerary_classes: "itinerary-line itinerary-line-night",
      text_color: "text-zinc-400",
    women_only_icon: "butterfly_night.svg"
    }.freeze

    def night_trip?
      hour = departure_time.hour

      hour >= 17 || hour < 4
    end

    def duration
      route.time_minutes
    end
end
