class Image::Header < Image
  has_attached_file :image, styles: {
    thumb: '100x40>',
    small: '400x160>',
    large: '1200'
  }
end
