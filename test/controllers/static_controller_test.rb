require 'test_helper'

class StaticControllerTest < ActionDispatch::IntegrationTest
  test "should get landingpage" do
    get static_landingpage_url
    assert_response :success
  end

end
