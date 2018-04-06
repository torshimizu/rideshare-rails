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
<<<<<<< HEAD
    return 0 if trips.empty? || trips.length == 1
=======
    return 0 if trips.empty? || (trips.length == 1 && trips.any? {|trip| trip.rating.nil? })
>>>>>>> 7222325c0ef8f7d787f5e42fff8df0543368a1d4
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

  def self.the_driver
    drivers = Driver.where(disabled: false)
    longest_driver_not_driving = drivers.first
    drivers.each do |driver|
      unless driver.driver_on_trip
        if driver.trips.empty? || driver.last_trip.date == nil
          longest_driver_not_driving = driver
          return longest_driver_not_driving
        elsif longest_driver_not_driving.trips.empty?
          longest_driver_not_driving = driver
          return longest_driver_not_driving
        else
          if longest_driver_not_driving.last_trip.date > driver.last_trip.date
            longest_driver_not_driving = driver
          end
        end
      end
    end
    return longest_driver_not_driving
  end

  def driver_on_trip
    self.trips.each do |trip|
      return true if trip.rating == nil
    end
    return false
  end
end
