require "test_helper"

class CombosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get combos_index_url
    assert_response :success
  end
end
