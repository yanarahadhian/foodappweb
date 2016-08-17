require 'test_helper'

class Admin::ReportsControllerTest < ActionController::TestCase
  test "should get items" do
    get :items
    assert_response :success
  end

  test "should get users" do
    get :users
    assert_response :success
  end

end
