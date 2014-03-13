class Image
  class Header < Image
    has_attached_file :image, styles: {
      thumb: '100x40>',
      small: '400x160>',
      large: '1200'
    }
    validates_attachment_content_type :image, content_type: CONTENT_TYPES
  end
end
