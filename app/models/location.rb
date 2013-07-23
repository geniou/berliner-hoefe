class Location < ActiveRecord::Base
  extend FriendlyId

  attr_accessible :name, :description, :annotations, :on_map, :published_on, :slug,
    :latitude, :longitude, :header_image_attributes, :slideshow_images_attributes

  has_one :header_image, class_name: Image::Header, dependent: :destroy
  accepts_nested_attributes_for :header_image, allow_destroy: true

  has_many :slideshow_images, class_name: Image::Slideshow,
    dependent: :destroy, order: :position
  accepts_nested_attributes_for :slideshow_images, allow_destroy: true,
    reject_if: :all_blank

  geocoded_by latitude:  :latitude, longitude: :longitude

  scope :newest, order: "published_on DESC", limit: 8
  scope :for_map, conditions: { on_map: true }
  scope :published, lambda { { conditions: [ "published_on < ?", Time.now ] } }

  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    slug.empty?
  end

  def nearbys_for_map
    nearbys.published.for_map.limit(8)
  end

  def as_json(options = {})
    super only: [:id, :name, :latitude, :longitude], methods: :url
  end

  def url
    # simple way to have url for json
    "/#{slug}"
  end
end
