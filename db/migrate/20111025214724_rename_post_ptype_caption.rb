class RenamePostPtypeCaption < ActiveRecord::Migration
  def change
    rename_column :posts,:ptype,:media_type
    rename_column :posts,:caption,:text
    rename_column :posts,:twitter_cross_post,:tw_crosspost
    rename_column :posts,:facebook_cross_post_pages,:fb_crosspost_pages
  end
end
