require 'test_helper'

class TradeControllerTest < ActionController::TestCase
  test "should get trade_requests" do
    get :trade_requests
    assert_response :success
  end

end
