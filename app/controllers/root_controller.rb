class RootController < ApplicationController

  def index
    @locations = Location.published.for_map
    @newest = @locations.newest
    @body_id = 'root'
  end

end
