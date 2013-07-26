class Image::Slideshow < Image
  validates_presence_of :image

  has_attached_file :image,
    styles: {
      thumb: "100x40>",
      small: "150x100#",
      large: "1000x666>",
    }
end
