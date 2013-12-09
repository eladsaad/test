require 'test_helper'

class Operation::PlayerGroupsControllerTest < ActionController::TestCase
  setup do
    @operation_player_group = operation_player_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:operation_player_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create operation_player_group" do
    assert_difference('Operation::PlayerGroup.count') do
      post :create, operation_player_group: { description: @operation_player_group.description, name: @operation_player_group.name, operator_id: @operation_player_group.operator_id, player_organization_id: @operation_player_group.player_organization_id, program_start_date: @operation_player_group.program_start_date, reg_code: @operation_player_group.reg_code }
    end

    assert_redirected_to operation_player_group_path(assigns(:operation_player_group))
  end

  test "should show operation_player_group" do
    get :show, id: @operation_player_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @operation_player_group
    assert_response :success
  end

  test "should update operation_player_group" do
    patch :update, id: @operation_player_group, operation_player_group: { description: @operation_player_group.description, name: @operation_player_group.name, operator_id: @operation_player_group.operator_id, player_organization_id: @operation_player_group.player_organization_id, program_start_date: @operation_player_group.program_start_date, reg_code: @operation_player_group.reg_code }
    assert_redirected_to operation_player_group_path(assigns(:operation_player_group))
  end

  test "should destroy operation_player_group" do
    assert_difference('Operation::PlayerGroup.count', -1) do
      delete :destroy, id: @operation_player_group
    end

    assert_redirected_to operation_player_groups_path
  end
end
