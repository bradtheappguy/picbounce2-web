class AddViewCountToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :view_count, :integer
  end

  def self.down

  end
end
