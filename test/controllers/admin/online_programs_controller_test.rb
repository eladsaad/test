require 'test_helper'

class Admin::OnlineProgramsControllerTest < ActionController::TestCase
  setup do
    @admin_online_program = admin_online_programs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_online_programs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_online_program" do
    assert_difference('Admin::OnlineProgram.count') do
      post :create, admin_online_program: { background_image_id: @admin_online_program.background_image_id, codename: @admin_online_program.codename, description: @admin_online_program.description, language_code_id: @admin_online_program.language_code_id, name: @admin_online_program.name, promo_video_id: @admin_online_program.promo_video_id }
    end

    assert_redirected_to admin_online_program_path(assigns(:admin_online_program))
  end

  test "should show admin_online_program" do
    get :show, id: @admin_online_program
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_online_program
    assert_response :success
  end

  test "should update admin_online_program" do
    patch :update, id: @admin_online_program, admin_online_program: { background_image_id: @admin_online_program.background_image_id, codename: @admin_online_program.codename, description: @admin_online_program.description, language_code_id: @admin_online_program.language_code_id, name: @admin_online_program.name, promo_video_id: @admin_online_program.promo_video_id }
    assert_redirected_to admin_online_program_path(assigns(:admin_online_program))
  end

  test "should destroy admin_online_program" do
    assert_difference('Admin::OnlineProgram.count', -1) do
      delete :destroy, id: @admin_online_program
    end

    assert_redirected_to admin_online_programs_path
  end
end
