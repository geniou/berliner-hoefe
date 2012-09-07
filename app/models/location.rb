class Location < ActiveRecord::Base
  attr_accessible :name, :description, :published_on, :slug, :classification, :latitude, :longitude, :show_detail

  geocoded_by :latitude  => :latitude, :longitude => :longitude

  scope :newest, order: "published_on DESC", limit: 8
  scope :for_map, conditions: { show_detail: true }
  scope :published, lambda { { conditions: [ "published_on > ?", Date.today ] } }

  extend FriendlyId
  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    slug.empty?
  end

end
