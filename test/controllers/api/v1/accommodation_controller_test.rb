require 'test_helper'

class Api::V1::AccommodationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_accommodation_index_url
    assert_response :success
  end

end
