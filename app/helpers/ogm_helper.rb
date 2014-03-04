module OgmHelper
  def ogm_image(image_url)
    content_tag :meta, nil, property: 'og:image', content: absolute_image_url(image_url)
  end

  def ogm_title(title)
    content_tag :meta, nil, property: 'og:title', content: title
  end

  def ogm_site_name(name)
    content_tag :meta, nil, property: 'og:page_title', content: name
  end

  private

  def absolute_image_url(image_url)
    URI.join(request.url, image_url)
  end
end
