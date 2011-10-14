class AddTypeToPhoto < ActiveRecord::Migration

def self.up
    add_column :photos,:type, :integer
end 

def self.down
    remove_column :photos, :type
end

end
