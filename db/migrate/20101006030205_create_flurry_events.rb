class CreateFlurryEvents < ActiveRecord::Migration
  def self.up 
    create_table :flurry_events do |t|
      t.date :date
      t.integer :session_index
      t.string :event
      t.string :description
      t.string :version
      t.string :platform
      t.string :device
      t.string :user_id
      t.string :params
      t.timestamps
    end
  end

  def self.down
    drop_table :flurry_events
  end
end
