class AddOptionalDataToUserTokens < ActiveRecord::Migration
  def self.up
    add_column :user_tokens, :email, :string
    add_column :user_tokens, :first_name, :string
    add_column :user_tokens, :last_name, :string
    add_column :user_tokens, :location, :string
    add_column :user_tokens, :description, :string
    add_column :user_tokens, :image, :string
    add_column :user_tokens, :phone, :string
    add_column :user_tokens, :urls, :string
    add_column :user_tokens, :user_hash, :string
  end

  def self.down
    remove_column :user_tokens, :email
    remove_column :user_tokens, :first_name
    remove_column :user_tokens, :last_name
    remove_column :user_tokens, :location
    remove_column :user_tokens, :description
    remove_column :user_tokens, :image
    remove_column :user_tokens, :phone
    remove_column :user_tokens, :urls
    remove_column :user_tokens, :user_hash
  end
end
