class AddDeletedToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :deleted, :integer
  end

  def self.down
    remove_column :photos, :deleted
  end
end
