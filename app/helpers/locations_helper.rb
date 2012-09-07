module LocationsHelper

  def map_data(locations, options = {})
    locations.map do |location|
      {
        :id => location.id,
        :name => location.name,
        :latitude => location.latitude,
        :longitude => location.longitude,
        :marker => location.classification.downcase,
        :url => location_path(location),
        :additional => options[:additional] || false
      }
    end.to_json.html_safe
  end

end
