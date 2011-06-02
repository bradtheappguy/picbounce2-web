class AddTypeToFilter < ActiveRecord::Migration
  def self.up
    add_column :filters, :filter_type, :string
  end

  def self.down
    remove_column :filters, :filter_type
  end
end
