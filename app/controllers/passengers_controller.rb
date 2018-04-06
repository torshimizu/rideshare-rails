class PassengersController < ApplicationController

  def index
    @passengers = Passenger.where(disabled: false)
  end

  def new
    @passenger = Passenger.new
  end

  def create
    @passenger = Passenger.new(passenger_params)

    if @passenger.save
      redirect_to passengers_path
    else
      render :new
    end
  end

  def show
    passenger_id = params[:id]
    @passenger = Passenger.find(passenger_id)
  end

  def edit
    @passenger = Passenger.find(params[:id])
  end

  def update
    @passenger = Passenger.find(params[:id])
    @passenger.assign_attributes(passenger_params)

    if @passenger.save
      redirect_to passengers_path
    else
      render :edit
    end
  end

  def destroy
    passenger = Passenger.find(params[:id])
    passenger.disabled = true
    if passenger.save
      redirect_to passengers_path
    else
      redirect_to passenger_path(passenger)
    end
  end

  def by_name
    passenger_name = params[:name]
    @passenger = Passenger.where(disabled: false).find_by(name: passenger_name)

    if @passenger == nil
      redirect_to passengers_path
    else
      redirect_to passenger_path(@passenger.id)
    end
  end

  private

  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)
  end

end
