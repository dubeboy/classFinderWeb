require 'test_helper'

class Api::V1::VenueFinderControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_venue_finder_index_url
    assert_response :success
  end

end
