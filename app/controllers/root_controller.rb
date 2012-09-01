class RootController < ApplicationController

  def index
    @locations = Location.all
    @newest = Location.newest
    @body_id = 'root'
  end

end
