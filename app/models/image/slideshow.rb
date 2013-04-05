class Image::Slideshow < Image
  has_attached_file :image,
    styles: {
      thumb: "100x40>",
      small: "150x100#",
      large: "1000x666>",
    }
end
