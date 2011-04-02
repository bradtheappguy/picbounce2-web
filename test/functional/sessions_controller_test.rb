require File.dirname(__FILE__) + '/../test_helper'

require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

# Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test "login page exists" do
    get :new
    assert_response :success
  end

  test "login page assigns a service status variable" do
    get :new
    assert_response :success
    assert_not_nil assigns(:service_status)
  end
end
