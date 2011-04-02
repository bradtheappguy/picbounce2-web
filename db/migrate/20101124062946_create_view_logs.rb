class CreateViewLogs < ActiveRecord::Migration
  def self.up 
    create_table :view_logs do |x| end
    add_column :view_logs, :code, :string
    add_column :view_logs, :user_agent, :string
    add_column :view_logs, :ip_address, :string
  end

  def self.down
    drop_table :view_logs
  end
end
