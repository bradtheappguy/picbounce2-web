class AddTwitterPostIdToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :twitter_post_id, :string
  end

  def self.down
    remove_column :photos, :twitter_post_id
  end
end
