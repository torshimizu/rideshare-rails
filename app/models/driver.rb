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

end
