require 'test_helper'

class SelectUserTypeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get select_user_type_index_url
    assert_response :success
  end

end
