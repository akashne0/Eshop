require "test_helper"

class PaypalsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get paypals_new_url
    assert_response :success
  end

  test "should get create" do
    get paypals_create_url
    assert_response :success
  end
end
