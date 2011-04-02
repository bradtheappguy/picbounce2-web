require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test "should redirect to login form" do
    get :index
    assert_response :redirect 
    assert_redirected_to(:controller =>'sessions', :action=>'create') 
  end
  
end
