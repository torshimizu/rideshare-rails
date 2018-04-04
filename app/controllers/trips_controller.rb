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

  def new
    @trip = Trip.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def trip_params
    return params.require(:trip).permit(:cost, :rate)
  end

end
