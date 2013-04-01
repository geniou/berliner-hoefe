class LocationsController < ApplicationController

  def index
    @locations = Location.published.for_map
    @newest = @locations.newest
    @body_id = 'root'
  end

  def show
    @location = Location.find(params[:id])
    @nearby = @location.nearbys_for_map
  end

  def redirect
    redirect_to action: 'show', id: params[:id], status: 301
  end
end
