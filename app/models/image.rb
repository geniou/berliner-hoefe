class Image < ActiveRecord::Base
  attr_accessible :image, :image_content_type, :image_file_name, :image_file_size, :location_id
  belongs_to :location
  has_attached_file :image,
    :styles => {
      :thumb => "100x100#",
      :small => "300x300>",
      :large => "750x500>"
        }

end
