require "test_helper"

class ForecastControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get forecast_index_url
    assert_response :success
  end

  test "should get show" do
    get forecast_show_url
    assert_response :success
  end
end
