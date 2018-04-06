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
