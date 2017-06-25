require 'test_helper'

class Api::V1::CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_comments_index_url
    assert_response :success
  end

  test "should get com" do
    get api_v1_comments_com_url
    assert_response :success
  end

end