class Location < ActiveRecord::Base
  has_one :header_image, class_name: Image::Header, dependent: :destroy
  accepts_nested_attributes_for :header_image, allow_destroy: true

  has_many :slideshow_images, -> { order :position },
           dependent: :destroy, class_name: Image::Slideshow
  accepts_nested_attributes_for :slideshow_images, allow_destroy: true,
                                                   reject_if: :all_blank

  geocoded_by latitude:  :latitude, longitude: :longitude

  scope :newest, -> { order('published_on DESC').limit(8) }
  scope :for_map, -> { where on_map: true }
  scope :published, -> { where ['published_on < ?', Time.now] }

  def nearbys_for_map
    return unless nearbys
    nearbys.published.for_map.limit(8)
  end

  def as_json(_options = {})
    super only: [:id, :name, :latitude, :longitude], methods: :url
  end

  def url
    # simple way to have url for json
    "/#{slug}"
  end
end
