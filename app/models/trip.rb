class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  def self.replace_deleted_driver(driver_id, replacement)
    trips = Trip.where(driver_id: driver_id)

    trips.each do |trip|
      trip.driver = replacement
      trip.save
    end
  end
end
