class AddTwAndFbSettingsToPost < ActiveRecord::Migration
  def change
    add_column :posts, :twitter_cross_post , :boolean
    add_column :posts, :facebook_cross_post_pages , :string
  end
end
