class Trip < ApplicationRecord
  belongs_to :route
  belongs_to :driver, class_name: "User"
  belongs_to :vehicle

  has_many :bookings, dependent: :destroy

  enum status: {
    draft: "draft",
    active: "active",
    full: "full",
    completed: "completed",
    cancelled: "cancelled"
  }

  validates :departure_time, :price, :seat_capacity, presence: true
  validates :seat_capacity, numericality: { greater_than: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  enum :statuses, 

  def arrival_time
    route.time_minutes

    #departure_time + route.time_minutes.minutes
  end

  def seats_left
    #seat_capacity - bookings.confirmed.count
  end
end
