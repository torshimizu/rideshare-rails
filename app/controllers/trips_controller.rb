class TripsController < ApplicationController
  def index
    driver = params[:driver_id]
    passenger = params[:passenger_id]
    if driver
      @trips = Trip.where(driver_id: driver)
    elsif passenger
      @trips = Trip.where(passenger_id: passenger)
    else
      @trips  = Trip.all
    end
  end

  def show
    @trip = Trip.find(params[:id])
    @driver = Driver.find(@trip.driver_id)
    @passenger = Passenger.find(@trip.passenger_id)
  end

  def new
    @trip = Trip.new(passenger_id: params[:passenger_id])
  end


  def create
    drivers = Driver.where(disabled: false)
    longest_driver_not_driving = nil
    drivers.each do |driver|
      if driver.trips.empty? || driver.last_trip.date == nil 
        longest_driver_not_driving = driver
      elsif longest_driver_not_driving == nil || longest_driver_not_driving.trips.empty?
        longest_driver_not_driving = driver
      else
        if longest_driver_not_driving.last_trip.date > driver.last_trip.date
          longest_driver_not_driving = driver
        end
      end
    end

    @trip = Trip.new(passenger_id: params[:passenger_id], driver_id: longest_driver_not_driving.id)
    @trip.date = Date.today
    cost = (1000..5000).to_a.sample
    @trip.cost = (cost/100.00).round(2)

    if @trip.save
      redirect_to trip_path(@trip)
    else
      redirect_to passenger_path(@trip.passenger_id)
    end

  end

  def edit; end

  def update
    @trip = Trip.find(params[:id])
    @trip.rating = params[:trip][:rating]

    @trip.save
    redirect_to trip_path(@trip)
  end

  def destroy
  end

  private

  def trip_params
    return params.require(:trip).permit(:cost, :rate)
  end

end
