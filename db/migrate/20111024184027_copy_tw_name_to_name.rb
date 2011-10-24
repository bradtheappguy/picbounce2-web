class CopyTwNameToName < ActiveRecord::Migration
  def change
    execute "update users set name = twitter_screen_name where name is null"
  end
end
