require "test_helper"

class RefundsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get refunds_update_url
    assert_response :success
  end

  test "should get destroy" do
    get refunds_destroy_url
    assert_response :success
  end
end
