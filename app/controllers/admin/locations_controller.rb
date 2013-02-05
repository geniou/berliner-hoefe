class Admin::LocationsController < Admin::ApplicationController
  def index
    @locations = Location.all
    @body_id = 'locations'
  end

  def new
    @location = Location.new
    @location.images.build
  end

  def create
    propperties = params[:location]
    propperties[:published_on] = propperties[:published_on] != 0 ? Time.now : nil
    @location = Location.new(propperties)
    if @location.save
      redirect_to @location, :notice => "Successfully created location."
    else
      render :action => 'new'
    end
  end

  def edit
    @location = Location.find(params[:id])
    @location.images.build
  end

  def update
    @location = Location.find(params[:id])
    propperties = params[:location]
    propperties[:published_on] = propperties[:published_on] != '0' ? @location.published_on || Time.now : nil
    if @location.update_attributes(propperties)
      redirect_to @location, :notice  => "Successfully updated location."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    redirect_to locations_url, :notice => "Successfully destroyed location."
  end

  def massoperation
    Location.perform_massoperation(params[:do], params[:massoperation])
    redirect_to :action => 'index'
  end
end
