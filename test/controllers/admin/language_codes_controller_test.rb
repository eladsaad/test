require 'test_helper'

class Admin::LanguageCodesControllerTest < ActionController::TestCase
  setup do
    @admin_language_code = admin_language_codes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_language_codes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_language_code" do
    assert_difference('Admin::LanguageCode.count') do
      post :create, admin_language_code: { code: @admin_language_code.code, name: @admin_language_code.name }
    end

    assert_redirected_to admin_language_code_path(assigns(:admin_language_code))
  end

  test "should show admin_language_code" do
    get :show, id: @admin_language_code
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_language_code
    assert_response :success
  end

  test "should update admin_language_code" do
    patch :update, id: @admin_language_code, admin_language_code: { code: @admin_language_code.code, name: @admin_language_code.name }
    assert_redirected_to admin_language_code_path(assigns(:admin_language_code))
  end

  test "should destroy admin_language_code" do
    assert_difference('Admin::LanguageCode.count', -1) do
      delete :destroy, id: @admin_language_code
    end

    assert_redirected_to admin_language_codes_path
  end
end
