class AddDeviceCharacteristicsToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :app_version, :string
    add_column :photos, :device_type, :string
    add_column :photos, :os_version, :string
    add_column :photos, :device_id, :string
    add_column :photos, :device_language, :string
  end

  def self.down
    remove_column :photos, :app_version 
    remove_column :photos, :device_type 
    remove_column :photos, :os_version
    remove_column :photos, :device_id
    remove_column :photos, :device_language
  end
end
