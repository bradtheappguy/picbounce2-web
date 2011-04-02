class AddBlockToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :block, :boolean
  end

  def self.down
    remove_column :photos, :block
  end
end
