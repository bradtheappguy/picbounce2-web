class RenameAuthenticationsToUserTokens < ActiveRecord::Migration
  def self.up
    rename_table :authentications, :user_tokens
  end

  def self.down
    rename_table :user_tokens, :authentications
  end
end
