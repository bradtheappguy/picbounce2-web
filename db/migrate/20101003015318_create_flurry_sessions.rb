class CreateFlurrySessions < ActiveRecord::Migration
def self.up
    create_table :flurry_records do |t|
      t.date :date
      t.integer :sessions
      t.integer :new_users
      t.integer :retained_users
      t.integer :active_users
      t.timestamps 
    end
  end

  def self.down
    drop_table :flurry_records
  end

end
