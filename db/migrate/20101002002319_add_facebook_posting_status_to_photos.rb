class AddFacebookPostingStatusToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :facebook_post_status_code, :string
    add_column :photos, :facebook_post_status_body, :string
  end

  def self.down
    remove_column :photos, :facebook_post_status_code
    remove_column :photos, :facebook_post_status_body
  end
end
