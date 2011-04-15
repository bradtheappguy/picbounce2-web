require File.dirname(__FILE__) + '/../test_helper'

 
class PhotosControllerTest < ActionController::TestCase

  fixtures :photos
  
  test "should get index" do
    get :index
    assert_response :success
    assert_equal 9, assigns(:recent_photos).length
  end

  test "should view twitter photo" do
    get :view, :id => photos(:photo_with_twitter).code
    assert_response :success
    assert_equal photos(:photo_with_twitter), assigns(:photo)
  end
  
# test "should not view fb photo" do
#   get :view, :id => photos(:photo_with_fb).code
#   assert_response 302
#   assert_nil assigns(:photo)
# end
  
  test "should block photo" do
    authenticate
    post :edit, :id => photos(:photo_with_fb_and_twitter).code, :status => "Block"
    assert_response 302
    assert_equal true, Photo.find(photos(:photo_with_fb_and_twitter)).block
  end
  
  test "should unblock photo" do
    authenticate  
    post :edit, :id => photos(:photo_with_fb_blocked).code, :status => "ok"
    assert_response 302
    assert_nil Photo.find(photos(:photo_with_fb_blocked)).block
  end

  test "should not block photo" do
    authenticate_wrong
    post :edit, :id => photos(:photo_with_fb_and_twitter).code, :status => "Block"
    assert_response 302
    assert_nil assigns(:photo)
  end
  
  test "should not unblock photo" do
    authenticate_wrong
    post :edit, :id => photos(:photo_with_fb_blocked).code, :status => "ok"
    assert_response 302
    assert_nil assigns(:photo)
  end

# NOTE: This works now, if you replace the tokens with valid ones
  test "create a photo" do
    old_count = Photo.count
    post :create, 
      :photo => fixture_file_upload("photo_sample.jpg", "image/jpeg"), 
      :twitter_oauth_token => '155714570-7nqyILm4Wx5zz3cdFE0W0rHFHRdHh9hS0n708csO', 
      :twitter_oauth_secret => 'qMKkRnm3UQlEzvHG5WPbUGb5fp3YRMTfrMcps1QspI',
      :facebook_access_token => '12&&&&&&5208417509976|9817ca3e6a2e8bd55c0f153a-1024064802|t1nfLPlbnBfewv6S5fhX8VntyLE', 
      :caption => 'functional test ' + Time.now().to_s,
      :device_id => '8da5a36ff265ad5d8d8d5036a91e2a363485211f'
    assert_equal old_count+1, Photo.count
  end

  def authenticate
    session[:username] = "test@clixtr.com"
    session[:password] = "hen12ik" 
  end

  def authenticate_wrong
    session[:username] = "tes@clixtr.com"
    session[:password] = "" 
  end
end
