class RootController < ApplicationController

  def index
    @locations = Location.all
    @newest = Location.newest
  end

end
