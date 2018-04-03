class DriversController < ApplicationController

  def index
    @drivers = Driver.all
  end

  def new
    @driver = Driver.new
  end

  def show
    @driver = Driver.find(params[:id])
  end

  def create
    new_driver = Driver.new(driver_params)
    if new_driver.save
      redirect_to drivers_path
    end
  end

  def edit
    @driver = Driver.find(params[:id])

  end

  def update
    updated_driver = Driver.find(params[:id])
    updated_driver = update_attributes(driver_params)

    if updated_driver.save
      redirect_to drivers_path

    end
  end





  private
  def driver_params
    return params.require(:driver).permit(:name, :vin)
  end
end
