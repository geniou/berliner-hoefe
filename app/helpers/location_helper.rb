module LocationHelper
  def location_path(location)
    "/#{location.slug}"
  end
end
