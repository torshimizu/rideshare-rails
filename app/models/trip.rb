class Trip < ApplicationRecord
  belongs_to :driver, optional: true
  belongs_to :passenger, optional: true
  validates :rating, on: :update ,numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

  def self.replace_deleted_driver(driver_id, replacement)
    trips = Trip.where(driver_id: driver_id)

    trips.each do |trip|
      trip.driver = replacement
      trip.save
    end
  end
end
