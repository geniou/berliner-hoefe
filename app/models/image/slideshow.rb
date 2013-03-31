class Image::Slideshow < Image
  has_attached_file :image,
    styles: {
      small: "150x100#",
      large: "1000x666>",
    }
end
