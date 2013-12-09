require 'test_helper'

class Admin::OperatorsControllerTest < ActionController::TestCase
  setup do
    @admin_operator = admin_operators(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_operators)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_operator" do
    assert_difference('Admin::Operator.count') do
      post :create, admin_operator: { country: @admin_operator.country, email: @admin_operator.email, name: @admin_operator.name, reg_code_prefix: @admin_operator.reg_code_prefix }
    end

    assert_redirected_to admin_operator_path(assigns(:admin_operator))
  end

  test "should show admin_operator" do
    get :show, id: @admin_operator
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_operator
    assert_response :success
  end

  test "should update admin_operator" do
    patch :update, id: @admin_operator, admin_operator: { country: @admin_operator.country, email: @admin_operator.email, name: @admin_operator.name, reg_code_prefix: @admin_operator.reg_code_prefix }
    assert_redirected_to admin_operator_path(assigns(:admin_operator))
  end

  test "should destroy admin_operator" do
    assert_difference('Admin::Operator.count', -1) do
      delete :destroy, id: @admin_operator
    end

    assert_redirected_to admin_operators_path
  end
end
