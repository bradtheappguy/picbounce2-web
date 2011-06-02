class CreateUserFilters < ActiveRecord::Migration
  def self.up
    create_table :user_filters do |t|
      t.integer :user_id
      t.integer :filter_id
      t.timestamps
    end
    
    
    add_index :user_filters, [:user_id,:filter_id]
  end

  def self.down
    drop_table :user_filters
  end
end
