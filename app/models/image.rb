class Image < ActiveRecord::Base
  attr_accessible :image, :image_content_type, :image_file_name, :image_file_size, :location_id, :display_type

  belongs_to :location
end
