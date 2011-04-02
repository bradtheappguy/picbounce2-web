class AddUserAgentToPhoto < ActiveRecord::Migration
  def self.up
    add_column :photos, :user_agent, :string
  end

  def self.down
    remove_column :photos, :user_agent
  end
end
