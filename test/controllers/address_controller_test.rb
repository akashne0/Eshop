require "test_helper"

class AddressControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get address_index_url
    assert_response :success
  end

  test "should get new" do
    get address_new_url
    assert_response :success
  end

  test "should get show" do
    get address_show_url
    assert_response :success
  end
end
