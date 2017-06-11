require 'test_helper'

class Api::V1::NetworksCatEventsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_networks_cat_events_create_url
    assert_response :success
  end

  test "should get subscribe" do
    get api_v1_networks_cat_events_subscribe_url
    assert_response :success
  end

end
