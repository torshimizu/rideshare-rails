class TripsController < ApplicationController
  def index
  @trips  = Trip.all
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






end
