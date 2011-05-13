class RenameUsertokensToServices < ActiveRecord::Migration
  def self.up
    rename_table :user_tokens, :services
  end

  def self.down
    rename_table :services, :user_tokens
  end
end
