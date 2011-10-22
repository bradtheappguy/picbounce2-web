class AddCharityToUser < ActiveRecord::Migration
  def change
    add_column :users, :charity_name , :string
    add_column :users, :charity_link , :string
    add_column :users, :charity_pic , :string
  end
end
