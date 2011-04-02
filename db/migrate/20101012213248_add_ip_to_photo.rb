class AddIpToPhoto < ActiveRecord::Migration
  def self.up
    add_column :photos, :ip_address, :string
  end

  def self.down
    remove_column :photos, :ip_address
  end
end
