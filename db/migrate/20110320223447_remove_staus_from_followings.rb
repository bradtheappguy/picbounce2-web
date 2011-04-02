class RemoveStausFromFollowings < ActiveRecord::Migration
  def self.up
    remove_column :followings, :status
  end

  def self.down
    add_column :followings, :status, :integer
  end
end
