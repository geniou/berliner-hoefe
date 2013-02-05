class Location < ActiveRecord::Base
  extend FriendlyId

  attr_accessible :name, :description, :published_on, :slug, :classification, :latitude, :longitude, :show_detail, :images_attributes

  has_one :header_image,      class_name: 'Image::Header',    dependent: :destroy
  has_many :slideshow_images, class_name: 'Image::Slideshow', dependent: :destroy
  accepts_nested_attributes_for :header_image,     :allow_destroy => true
  accepts_nested_attributes_for :slideshow_images, :allow_destroy => true

  geocoded_by :latitude  => :latitude, :longitude => :longitude

  scope :newest, order: "published_on DESC", limit: 8
  scope :for_map, conditions: { on_map: true }
  scope :published, lambda { { conditions: [ "published_on < ?", Time.now ] } }

  friendly_id :name, use: :slugged

  def self.perform_massoperation(operation, ids)
    attributes = case operation
      when 'publish'
        { published_on: Time.now }
      when 'unpublish'
        { published_on: nil }
      when 'show_detail'
        { published_on: Time.now, show_detail: true }
      when 'hide_detail'
        { show_detail: false }
      when 'show_on_map'
        { published_on: Time.now, on_map: true }
      when 'hide_on_map'
        { on_map: false }
    end
    if attributes
      Location.update_all( attributes, [ "id IN (?)", ids ] )
    end
  end

  def should_generate_new_friendly_id?
    slug.empty?
  end

  def nearbys_for_map
    nearbys.published.for_map.limit(5)
  end

end
