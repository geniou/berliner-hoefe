class RemoveShowDetailFromLocation < ActiveRecord::Migration
  def up
    remove_column :locations, :show_detail
  end

  def down
  end
end
