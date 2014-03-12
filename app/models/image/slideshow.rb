class Image::Slideshow < Image
  has_attached_file :image, styles: {
    thumb: '100x40>',
    small: '150x100#',
    large: '1000x666>'
  }
  validates :image, presence: true
  validates_attachment_content_type :image,
    content_type: %w(image/jpg image/jpeg image/png)
end
