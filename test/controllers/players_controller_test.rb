require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  setup do
    @player = players(:one)
  end

  test "should get dashboard" do
    get :dashboard
    assert_response :success
  end

end
