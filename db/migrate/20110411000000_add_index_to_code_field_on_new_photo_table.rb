class AddIndexToCodeFieldOnNewPhotoTable < ActiveRecord::Migration
  def self.up
    add_index :photos, :code
  end

  def self.down
    remove_index :photos, :code
  end
end
