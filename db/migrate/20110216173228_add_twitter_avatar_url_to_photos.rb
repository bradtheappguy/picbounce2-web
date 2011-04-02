class AddTwitterAvatarUrlToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :twitter_avatar_url, :string
  end

  def self.down
    add_column :photos, :twitter_avatar_url, :string
  end
end
