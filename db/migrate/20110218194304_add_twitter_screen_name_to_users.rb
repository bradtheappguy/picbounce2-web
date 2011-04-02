class AddTwitterScreenNameToUsers < ActiveRecord::Migration
  def self.up
    add_column :photos, :migrated, :string

    add_column :users, :twitter_screen_name,   :string
    add_column :users, :twitter_oauth_token,   :string
    add_column :users, :twitter_oauth_secret,  :string
    add_column :users, :twitter_avatar_url,    :string
    add_column :users, :facebook_access_token, :string
    add_column :users, :facebook_user_id,      :string
  end #of self.up

  def self.down
    remove_column :photos, :migrated

    remove_column :users, :twitter_screen_name
    remove_column :users, :twitter_oauth_secret
    remove_column :users, :twitter_screen_name
    remove_column :users, :twitter_avatar_url
    remove_column :users, :facebook_access_token
    remove_column :users, :facebook_user_id


  end

 end
