class RenameUserTwFbSettings < ActiveRecord::Migration
  def change
    rename_column :users,:twitter_cross_post,:tw_crosspost
    rename_column :users,:facebook_cross_post_pages,:fb_crosspost_pages
    rename_column :users,:facebook_like_target,:fb_like_target
  end
end
