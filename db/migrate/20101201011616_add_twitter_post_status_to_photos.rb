class AddTwitterPostStatusToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :twitter_post_status_body, :text
    add_column :photos, :twitter_post_status_code, :text
  end

  def self.down
    remove_column :photos, :twitter_post_status_body, :text
    remove_column :photos, :twitter_post_status_code, :text
  end
end
