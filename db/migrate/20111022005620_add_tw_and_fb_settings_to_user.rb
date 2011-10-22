class AddTwAndFbSettingsToUser < ActiveRecord::Migration
  def change
    add_column :users, :twitter_cross_post , :boolean
    add_column :users, :facebook_cross_post_pages , :string
    add_column :users, :facebook_like_target , :string
  end
end
