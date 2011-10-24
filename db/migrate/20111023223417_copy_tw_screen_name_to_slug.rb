class CopyTwScreenNameToSlug < ActiveRecord::Migration
  def change
    execute "update users set slug = twitter_screen_name where slug is null"
  end
end
