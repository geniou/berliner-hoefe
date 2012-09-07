class RootController < ApplicationController

  def index
    @locations = Location.published.for_map
    @newest = Location.published.for_map.newest
    @body_id = 'root'
  end

end
