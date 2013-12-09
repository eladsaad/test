require 'test_helper'

class Admin::SystemAdminsControllerTest < ActionController::TestCase
  setup do
    @admin_system_admin = admin_system_admins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_system_admins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_system_admin" do
    assert_difference('Admin::SystemAdmin.count') do
      post :create, admin_system_admin: { email: @admin_system_admin.email, first_name: @admin_system_admin.first_name, last_name: @admin_system_admin.last_name }
    end

    assert_redirected_to admin_system_admin_path(assigns(:admin_system_admin))
  end

  test "should show admin_system_admin" do
    get :show, id: @admin_system_admin
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_system_admin
    assert_response :success
  end

  test "should update admin_system_admin" do
    patch :update, id: @admin_system_admin, admin_system_admin: { email: @admin_system_admin.email, first_name: @admin_system_admin.first_name, last_name: @admin_system_admin.last_name }
    assert_redirected_to admin_system_admin_path(assigns(:admin_system_admin))
  end

  test "should destroy admin_system_admin" do
    assert_difference('Admin::SystemAdmin.count', -1) do
      delete :destroy, id: @admin_system_admin
    end

    assert_redirected_to admin_system_admins_path
  end
end
