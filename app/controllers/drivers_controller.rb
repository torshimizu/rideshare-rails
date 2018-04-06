class DriversController < ApplicationController

  def index
    @drivers = Driver.where(disabled: false)
  end

  def new
    @driver = Driver.new
  end

  def show
    @driver = Driver.find(params[:id])
  end

  def create
    @driver = Driver.new(driver_params)
    if @driver.save
      redirect_to driver_path(@driver.id)
    else
      render :new
    end
  end

  def edit
    @driver = Driver.find(params[:id])

  end

  def update

    @driver = Driver.find(params[:id])
    @driver.update_attributes(driver_params)

    if @driver.save
      redirect_to driver_path(@driver.id)
    else
      render :edit

    end
  end

  def by_name
    driver_name = params[:name]

    @drivers = Driver.where(disabled: false).where(name: driver_name)

    render :index
  end


  def destroy

    driver = Driver.find(params[:id])
    driver.disabled = true
    if driver.save
      redirect_to drivers_path
    else
      redirect_to driver_path(driver)
    end
  end


  private

  def driver_params
    return params.require(:driver).permit(:name, :vin)
  end
end
