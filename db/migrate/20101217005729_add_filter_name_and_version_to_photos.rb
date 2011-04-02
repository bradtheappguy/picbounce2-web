class AddFilterNameAndVersionToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :filter_name, :string
    add_column :photos, :filter_version, :string
  end

  def self.down
    remove_column :photos, :filter_version
    remove_column :photos, :filter_name
  end
end
