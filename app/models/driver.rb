class Driver < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :vin, presence: true

  def earnings
    earnings = 0
      self.trips.each do |trip|
        next if trip.cost.nil?
        earnings += trip.cost
      end
    return earnings
  end

  def average_rating
    count = 0
    stars = 0
    return 0 if trips.empty?
    self.trips.each do |trip|
      next if trip.rating.nil?
      count +=1
      stars += trip.rating
    end
    return stars/count
  end

  def last_trips
    ended_trips = self.trips.where.not(updated_at: nil)
    return ended_trips.max_by {|trip| trip.updated_at }
  end

  def check_if_no_trips
    active_drivers = Driver.where(disabled: false)
    drivers_with_no_trips = active_drivers.select {|driver| driver.trips.empty?}

    if !drivers_with_no_trips.empty?
      return drivers_with_no_trips.first
    end

    return active_drivers
  end

  def get_last_driver
    trips_or_driver = check_if_no_trips

    if trips_or_driver.length > 1
      last_trips = trips_or_driver.map {|driver| driver.last_trip}
      last_trip = last_trips.order(:updated_at).first

      return last_trip
    end
    return trips_or_driver
  end
end
