class Location < ActiveRecord::Base
  extend FriendlyId

  attr_accessible :name, :description, :published_on, :slug, :classification,
    :latitude, :longitude, :show_detail, :header_image_attributes,
    :slideshow_images_attributes, :annotations, :on_map

  has_one :header_image, class_name: Image::Header, dependent: :destroy
  accepts_nested_attributes_for :header_image, allow_destroy: true

  has_many :slideshow_images, class_name: Image::Slideshow,
    dependent: :destroy, order: :position
  accepts_nested_attributes_for :slideshow_images, allow_destroy: true,
    reject_if: proc { |attributes| !attributes['image'].present? }

  geocoded_by :latitude  => :latitude, :longitude => :longitude

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

end
