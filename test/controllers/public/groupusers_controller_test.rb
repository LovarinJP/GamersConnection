require "test_helper"

class Public::GroupusersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_groupusers_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_groupusers_destroy_url
    assert_response :success
  end
end
