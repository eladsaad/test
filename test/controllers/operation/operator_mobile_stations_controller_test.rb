require 'test_helper'

class Operation::OperatorMobileStationsControllerTest < ActionController::TestCase
  setup do
    @operation_operator_mobile_station = operation_operator_mobile_stations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:operation_operator_mobile_stations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create operation_operator_mobile_station" do
    assert_difference('Operation::OperatorMobileStation.count') do
      post :create, operation_operator_mobile_station: { code: @operation_operator_mobile_station.code, operator_id: @operation_operator_mobile_station.operator_id }
    end

    assert_redirected_to operation_operator_mobile_station_path(assigns(:operation_operator_mobile_station))
  end

  test "should show operation_operator_mobile_station" do
    get :show, id: @operation_operator_mobile_station
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @operation_operator_mobile_station
    assert_response :success
  end

  test "should update operation_operator_mobile_station" do
    patch :update, id: @operation_operator_mobile_station, operation_operator_mobile_station: { code: @operation_operator_mobile_station.code, operator_id: @operation_operator_mobile_station.operator_id }
    assert_redirected_to operation_operator_mobile_station_path(assigns(:operation_operator_mobile_station))
  end

  test "should destroy operation_operator_mobile_station" do
    assert_difference('Operation::OperatorMobileStation.count', -1) do
      delete :destroy, id: @operation_operator_mobile_station
    end

    assert_redirected_to operation_operator_mobile_stations_path
  end
end
