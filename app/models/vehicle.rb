class Vehicle < ApplicationRecord
  COLORS = %w[ red gold yellow green blue brown black grey silver white ].freeze

  belongs_to :user
end

