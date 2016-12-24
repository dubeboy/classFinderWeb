require 'test_helper'

class SuperUserControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get super_user_index_url
    assert_response :success
  end

end
