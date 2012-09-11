class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :location_id
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.string :image_title

      t.timestamps
    end
  end
end
