require 'test_helper'

class PlayerGroupsControllerTest < ActionController::TestCase
  setup do
    @player_group = player_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:player_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create player_group" do
    assert_difference('PlayerGroup.count') do
      post :create, player_group: { description: @player_group.description, name: @player_group.name, operator_id: @player_group.operator_id, player_organization_id: @player_group.player_organization_id, program_start_date: @player_group.program_start_date, reg_code: @player_group.reg_code }
    end

    assert_redirected_to player_group_path(assigns(:player_group))
  end

  test "should show player_group" do
    get :show, id: @player_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @player_group
    assert_response :success
  end

  test "should update player_group" do
    patch :update, id: @player_group, player_group: { description: @player_group.description, name: @player_group.name, operator_id: @player_group.operator_id, player_organization_id: @player_group.player_organization_id, program_start_date: @player_group.program_start_date, reg_code: @player_group.reg_code }
    assert_redirected_to player_group_path(assigns(:player_group))
  end

  test "should destroy player_group" do
    assert_difference('PlayerGroup.count', -1) do
      delete :destroy, id: @player_group
    end

    assert_redirected_to player_groups_path
  end
end
