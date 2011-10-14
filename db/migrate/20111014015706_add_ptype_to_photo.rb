class AddPtypeToPhoto < ActiveRecord::Migration

def self.up
    remove_column :photos, :type
    add_column :photos,:ptype, :string
end 

def self.down
    add_column :photos,:type, :integer
    remove_column :photos, :ptype
end 

end
