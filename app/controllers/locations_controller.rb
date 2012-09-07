class LocationsController < ApplicationController

  def show
    @location = Location.find(params[:id])
    @nearby = @location.nearbys.published.for_map.limit(5)
  end

end
