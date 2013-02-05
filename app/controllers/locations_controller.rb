class LocationsController < ApplicationController

  def show
    @location = Location.find(params[:id])
    @nearby = @location.nearbys_for_map
  end

end
