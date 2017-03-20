require 'test_helper'

class Api::V1::NetworksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_networks_index_url
    assert_response :success
  end

end
