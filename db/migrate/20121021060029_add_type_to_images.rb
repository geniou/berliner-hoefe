class AddTypeToImages < ActiveRecord::Migration
  def change
    add_column :images, :display_type, :string
  end
end
