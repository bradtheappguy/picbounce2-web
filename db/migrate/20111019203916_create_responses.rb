class CreateResponses < ActiveRecord::Migration
  def up
   create_table :responses
  end

  def down
   drop_table :responses
  end
end
