require "test_helper"

class TrackOrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get track_orders_show_url
    assert_response :success
  end
end
