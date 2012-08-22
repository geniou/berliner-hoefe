module ApplicationHelper

  def map_data(locations)
    locations = [locations] unless locations.is_a?(Array)
    locations.map do |location|
      {
        :name => location.name,
        :latitude => location.latitude,
        :longitude => location.longitude,
        :marker => location.classification.downcase,
        :url => location_path(location)
      }
    end.to_json.html_safe
  end

  def markdown(text)
    options = [:hard_wrap => true]
    md = Redcarpet::Markdown.new(Redcarpet::Render::HTML, *options)
    md.render(text).html_safe  
  end  

end
