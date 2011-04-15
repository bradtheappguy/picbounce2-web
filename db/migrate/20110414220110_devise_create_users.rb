class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable
    end

#    add_index :users, :email,                :unique => true
#    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
  end

  def self.down
    remove_column :users, :database_authenticatable
    remove_column :users, :recoverable
    remove_column :users, :rememberable
    remove_column :users, :trackable
    remove_index :users, :email
    remove_index :users, :reset_password_token
  end
end
