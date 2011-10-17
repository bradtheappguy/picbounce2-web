class RenamePhotoToPost < ActiveRecord::Migration

def self.up
    rename_table :photos,:posts
    rename_column :comments ,:photo_id, :post_id
end 

def self.down
    rename_table :posts,:photos
    rename_column :comments , :post_id,:photo_id
end 

end
