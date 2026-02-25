class Rideshare < ApplicationRecord
  belongs_to :trip
  belongs_to :driver, class_name: "User"
  belongs_to :vehicle
end
