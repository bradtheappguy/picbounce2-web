class AddTwitterScreenName < ActiveRecord::Migration
  def self.up
    add_column :photos, :twitter_screen_name, :string
  end

  def self.down
    remove_column :photos, :twitter_screen_name
  end
end
