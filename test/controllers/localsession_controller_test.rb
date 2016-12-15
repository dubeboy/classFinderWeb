require 'test_helper'

class LocalsessionControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get localsession_create_url
    assert_response :success
  end

end
