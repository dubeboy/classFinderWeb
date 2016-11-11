require 'test_helper'

class AccomodationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get accomodation_index_url
    assert_response :success
  end

end
