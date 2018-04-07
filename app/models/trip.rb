class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger
  validates :rating, on: :update, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

end
