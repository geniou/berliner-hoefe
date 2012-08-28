class Location < ActiveRecord::Base
  attr_accessible :name, :description, :published_on, :slug, :classification, :latitude, :longitude

  geocoded_by :latitude  => :latitude, :longitude => :longitude

  scope :newest, order: "published_on DESC", limit: 8

  extend FriendlyId
  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    slug.empty?
  end

end
