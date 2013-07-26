class LocationsController < ApplicationController

  def index
    @locations = Location.published.for_map
    @footer_locations = @locations.newest
    @body_id = 'root'
  end

  def show
    @location = Location.find_by_slug(params[:id])
    @footer_locations = @nearby = @location.nearbys_for_map
  end

  def redirect
    redirect_to action: 'show', id: params[:id], status: 301
  end
end
