require "test_helper"

class RedeemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get redeems_index_url
    assert_response :success
  end
end
