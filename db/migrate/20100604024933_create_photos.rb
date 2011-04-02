class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.string :code
      t.timestamps
    end
      add_column :photos, :photo_file_name, :string # Original filename
      add_column :photos, :photo_content_type, :string # Mime type
      add_column :photos, :photo_file_size, :integer # File size in bytes
      add_column :photos, :twitter_oauth_token, :string
      add_column :photos, :twitter_oauth_secret, :string
      add_column :photos, :caption, :string
      add_column :photos, :facebook_access_token, :string
  end

  def self.down
    drop_table :photos
  end
end
