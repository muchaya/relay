class Vehicle < ApplicationRecord
  COLORS = %w[ black blue brown gold green grey red silver white yellow ].freeze

  belongs_to :user
end

