class AddRoationToPhoto < ActiveRecord::Migration
  def self.up
    add_column :photos, :rotation, :integer
  end

  def self.down
    remove_column :photos, :rotation
  end
end
