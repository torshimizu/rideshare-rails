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

  def last_trip
    drivers_trips = self.trips.order(date: :desc)
    if drivers_trips.length == 0
      nil
    end
    return drivers_trips.first
  end

  def the_driver
    longest_driver_not_driving = nil
    drivers = Driver.where(disabled: false)
    drivers.each do |driver|
      if longest_driver_not_driving == nil
        longest_driver_not_driving = driver
      else
        if longest_driver_not_driving.last_trip.date > driver.last_trip.date
          longest_driver_not_driving = driver
        end
      end
      return longest_driver_not_driving
    end
  end

  def driver_on_trip
    self.trips.each do |trip|
      return true if trip.rating == nil
    end
    return false
  end
end
