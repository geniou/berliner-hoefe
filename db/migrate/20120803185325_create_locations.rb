class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :name
      t.text :description
      t.timestamp :published_on
      t.string :slug
      t.string :type
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
    add_index :locations, :slug, unique: true
  end

  def self.down
    drop_table :locations
  end
end
