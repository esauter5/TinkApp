require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get register_device" do
    get :register_device
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
