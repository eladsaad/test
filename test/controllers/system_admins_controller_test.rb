require 'test_helper'

class SystemAdminsControllerTest < ActionController::TestCase
  setup do
    @system_admin = system_admins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:system_admins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create system_admin" do
    assert_difference('SystemAdmin.count') do
      post :create, system_admin: { email: @system_admin.email, first_name: @system_admin.first_name, last_name: @system_admin.last_name }
    end

    assert_redirected_to system_admin_path(assigns(:system_admin))
  end

  test "should show system_admin" do
    get :show, id: @system_admin
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @system_admin
    assert_response :success
  end

  test "should update system_admin" do
    patch :update, id: @system_admin, system_admin: { email: @system_admin.email, first_name: @system_admin.first_name, last_name: @system_admin.last_name }
    assert_redirected_to system_admin_path(assigns(:system_admin))
  end

  test "should destroy system_admin" do
    assert_difference('SystemAdmin.count', -1) do
      delete :destroy, id: @system_admin
    end

    assert_redirected_to system_admins_path
  end
end
