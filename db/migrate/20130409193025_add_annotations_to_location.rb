class AddAnnotationsToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :annotations, :text, null: true
  end
end
