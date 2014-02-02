require 'test_helper'

class Admin::NotificationsControllerTest < ActionController::TestCase
  setup do
    @admin_notification = admin_notifications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_notifications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_notification" do
    assert_difference('Admin::Notification.count') do
      post :create, admin_notification: { email_content: @admin_notification.email_content, facebook_content: @admin_notification.facebook_content, language_code: @admin_notification.language_code, name: @admin_notification.name, title: @admin_notification.title }
    end

    assert_redirected_to admin_notification_path(assigns(:admin_notification))
  end

  test "should show admin_notification" do
    get :show, id: @admin_notification
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_notification
    assert_response :success
  end

  test "should update admin_notification" do
    patch :update, id: @admin_notification, admin_notification: { email_content: @admin_notification.email_content, facebook_content: @admin_notification.facebook_content, language_code: @admin_notification.language_code, name: @admin_notification.name, title: @admin_notification.title }
    assert_redirected_to admin_notification_path(assigns(:admin_notification))
  end

  test "should destroy admin_notification" do
    assert_difference('Admin::Notification.count', -1) do
      delete :destroy, id: @admin_notification
    end

    assert_redirected_to admin_notifications_path
  end
end
