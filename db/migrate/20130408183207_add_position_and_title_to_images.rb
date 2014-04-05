class AddPositionAndTitleToImages < ActiveRecord::Migration
  def up
    add_column :images, :position, :integer
    rename_column :images, :image_title, :title
  end

  def down
    remove_column :images, :position
    rename_column :images, :title, :image_title
  end
end
