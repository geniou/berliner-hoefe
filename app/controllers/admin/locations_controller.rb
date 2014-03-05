class Admin::LocationsController < Admin::ApplicationController
  include LocationHelper

  def index
    @locations = Location.all
    @body_id = 'locations'
  end

  def new
    @location = Location.new
    @location.build_header_image
    @location.slideshow_images.build
  end

  def create
    propperties = location_params
    propperties[:published_on] = propperties[:published_on] != 0 ? Time.now : nil
    @location = Location.new(propperties)
    if @location.save
      redirect_to @location.url, notice: 'Successfully created location.'
    else
      render action: 'new'
    end
  end

  def edit
    @location = Location.find(params[:id])
    @location.build_header_image unless @location.header_image
    10.times { @location.slideshow_images.build }
  end

  def update
    @location = Location.find(params[:id])
    propperties = location_params
    propperties[:published_on] = propperties[:published_on] != '0' ? @location.published_on || Time.now : nil
    if @location.update_attributes(propperties)
      redirect_to location_path(@location), notice:  'Successfully updated location.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    redirect_to locations_url, notice: 'Successfully destroyed location.'
  end

  private

  def location_params
    params.require(:location).permit!
  end
end
