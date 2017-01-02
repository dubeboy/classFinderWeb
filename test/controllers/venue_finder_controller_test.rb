require 'test_helper'

class VenueFinderControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get venue_finder_index_url
    assert_response :success
  end

end
