class Image::Header < Image
  has_attached_file :image,
    styles: {
      small: "200x80>",
      large: "1200x500>",
    }
end
