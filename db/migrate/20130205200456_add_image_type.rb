class AddImageType < ActiveRecord::Migration
  def up
    add_column :images, :type, :string, default: 'Image::Slideshow'
    Image.find_all_by_display_type('header').each do |image|
      image.type = 'Image::Header'
      image.save
    end
    change_column :images, :type, :string, null: false
    remove_column :images, :display_type
  end

  def down
    add_column :images, :display_type, :string
    Image.all.each do |image|
      image.display_type = image.type == 'Image::Header' ? 'header' : nil
      image.save
    end
    remove_column :images, :type
  end
end
