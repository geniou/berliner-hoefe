module LocationsHelper

  def map_data(locations, options = {})
    locations.map do |location|
      {
        :id => location.id,
        :name => location.name,
        :latitude => location.latitude,
        :longitude => location.longitude,
        :url => location_path(location),
        :additional => options[:additional] || false,
        :show_detail => location.show_detail
      }
    end.to_json.html_safe
  end

end
