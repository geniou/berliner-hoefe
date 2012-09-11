class Location < ActiveRecord::Base
  attr_accessible :name, :description, :published_on, :slug, :classification, :latitude, :longitude, :show_detail, :images_attributes
  
  has_many :images, :dependent => :destroy
  accepts_nested_attributes_for :images, :allow_destroy => true

  geocoded_by :latitude  => :latitude, :longitude => :longitude

  scope :newest, order: "published_on DESC", limit: 8
  scope :for_map, conditions: { on_map: true }
  scope :published, lambda { { conditions: [ "published_on < ?", Time.now ] } }

  extend FriendlyId
  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    slug.empty?
  end

end
