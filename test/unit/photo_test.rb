require 'test_helper'
     
class ViewLogTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "Photos has index on code column" do
    assert ActiveRecord::Base.connection.indexes('photos')[0]['columns'].index('code')
  end

  test "uuid can be assigned to photo" do
    p = Photo.new
    p.set_uuid
    assert p.uuid
  end

   test "filter name can be assigned to photo" do
    filter_name = "Awesome Filter"
    p = Photo.new
    p.filter_name = filter_name
    assert p.filter_name
  end

  test "filter version can be assigned to photo" do
    filter_version = "1"
    p = Photo.new
    p.filter_version = filter_version
    assert p.filter_version
  end

  test "recent photos exist" do
    assert Photo.recent
  end
  
  test "recent photos are limited to 9" do
    puts "OUTPUT:::: #{Photo.count}"
    puts "OUTPUT:::: #{Photo.recent.length}"
    assert Photo.recent.length == 9
  end

end
