require 'test_helper'

class Admin::InteractiveVideosControllerTest < ActionController::TestCase
  setup do
    @admin_interactive_video = admin_interactive_videos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_interactive_videos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_interactive_video" do
    assert_difference('Admin::InteractiveVideo.count') do
      post :create, admin_interactive_video: { content: @admin_interactive_video.content, description: @admin_interactive_video.description, language_code: @admin_interactive_video.language_code, name: @admin_interactive_video.name }
    end

    assert_redirected_to admin_interactive_video_path(assigns(:admin_interactive_video))
  end

  test "should show admin_interactive_video" do
    get :show, id: @admin_interactive_video
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_interactive_video
    assert_response :success
  end

  test "should update admin_interactive_video" do
    patch :update, id: @admin_interactive_video, admin_interactive_video: { content: @admin_interactive_video.content, description: @admin_interactive_video.description, language_code: @admin_interactive_video.language_code, name: @admin_interactive_video.name }
    assert_redirected_to admin_interactive_video_path(assigns(:admin_interactive_video))
  end

  test "should destroy admin_interactive_video" do
    assert_difference('Admin::InteractiveVideo.count', -1) do
      delete :destroy, id: @admin_interactive_video
    end

    assert_redirected_to admin_interactive_videos_path
  end
end
