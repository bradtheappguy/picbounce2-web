class AddUuidToPhoto < ActiveRecord::Migration
  def self.up
    add_column :photos, :uuid, :string
    #Photo.all.each {|photo| photo.uuid = photo.id; photo.save}
  end

  def self.down
    remove_column :photos, :uuid
  end
end
