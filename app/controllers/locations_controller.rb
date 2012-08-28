class LocationsController < ApplicationController

  def show
    @location = Location.find(params[:id])
    @nearby = @location.nearbys.limit(5)
  end

end
