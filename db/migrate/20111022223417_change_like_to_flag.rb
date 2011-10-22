class ChangeLikeToFlag < ActiveRecord::Migration
  def change
    rename_table :likes, :flags
    rename_column :flags, :photo_id, :post_id
  end
end
