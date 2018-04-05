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
      redirect_to driver_path(new_driver.id)
    end
  end

  def edit
    @driver = Driver.find(params[:id])

  end

  def update

    the_driver = Driver.find(params[:id])
    the_driver.update_attributes(driver_params)

    if the_driver.save
      redirect_to driver_path(the_driver.id)

    end
  end

  def by_name
    driver_name = params[:name]

    @driver = Driver.find_by(name: driver_name)

    if @driver == nil
      redirect_to drivers_path
    else
      redirect_to driver_path(@driver)
    end
  end

  def destroy
     Driver.destroy(params[:id])

     redirect_to drivers_path
  end

  private
  def driver_params
    return params.require(:driver).permit(:name, :vin)
  end
end
