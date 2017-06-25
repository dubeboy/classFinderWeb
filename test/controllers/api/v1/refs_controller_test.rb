require 'test_helper'

class Api::V1::RefsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_refs_index_url
    assert_response :success
  end

end
