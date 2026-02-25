class Vehicle < ApplicationRecord
  belongs_to :owner, class_name: "User", optional: true
  belongs_to :operator, optional: true
end
