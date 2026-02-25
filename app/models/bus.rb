class Bus < ApplicationRecord
  belongs_to :trip
  belongs_to :operator
  belongs_to :vehicle
end
