class Location < ActiveRecord::Base
  attr_accessible :name, :description, :published_on, :slug, :classification, :latitude, :longitude

  scope :newest, order: "published_on DESC", limit: 10

  extend FriendlyId
  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    slug.empty?
  end

end
