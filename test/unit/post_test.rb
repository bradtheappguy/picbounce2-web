require 'test_helper'
     
class ViewLogTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "Photos has index on code column" do
    test = false
    ActiveRecord::Base.connection.indexes('photos').collect{|index| test = true if index.columns[0] == "code"}
    assert test
  end

  test "uuid can be assigned to photo" do
    p = Post.new
    p.set_uuid
    assert p.uuid
  end

   test "filter name can be assigned to photo" do
    filter_name = "Awesome Filter"
    p = Post.new
    p.filter_name = filter_name
    assert p.filter_name
  end

  test "filter version can be assigned to photo" do
    filter_version = "1"
    p = Post.new
    p.filter_version = filter_version
    assert p.filter_version
  end

  test "recent photos exist" do
    assert Post.recent
  end
  
  test "recent photos are limited to 9" do
    puts "OUTPUT:::: #{Post.count}"
    puts "OUTPUT:::: #{Post.recent.length}"
    assert Post.recent.length == 9
  end

end
