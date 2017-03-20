require 'test_helper'

class Api::V1::NetworkPostsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_network_posts_create_url
    assert_response :success
  end

  test "should get index" do
    get api_v1_network_posts_index_url
    assert_response :success
  end

end
