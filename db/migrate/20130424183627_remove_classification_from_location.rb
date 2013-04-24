class RemoveClassificationFromLocation < ActiveRecord::Migration
  def change
    remove_column :locations, :classification
  end
end
