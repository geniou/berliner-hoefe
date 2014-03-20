class Image < ActiveRecord::Base
  belongs_to :location
  CONTENT_TYPES = %w(image/jpg image/jpeg image/png)
end
