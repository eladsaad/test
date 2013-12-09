require 'test_helper'

class Operation::PlayerOrganizationsControllerTest < ActionController::TestCase
  setup do
    @operation_player_organization = operation_player_organizations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:operation_player_organizations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create operation_player_organization" do
    assert_difference('Operation::PlayerOrganization.count') do
      post :create, operation_player_organization: { address: @operation_player_organization.address, contact_email: @operation_player_organization.contact_email, contact_name: @operation_player_organization.contact_name, contact_phone: @operation_player_organization.contact_phone, contact_position: @operation_player_organization.contact_position, name: @operation_player_organization.name, org_type: @operation_player_organization.org_type }
    end

    assert_redirected_to operation_player_organization_path(assigns(:operation_player_organization))
  end

  test "should show operation_player_organization" do
    get :show, id: @operation_player_organization
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @operation_player_organization
    assert_response :success
  end

  test "should update operation_player_organization" do
    patch :update, id: @operation_player_organization, operation_player_organization: { address: @operation_player_organization.address, contact_email: @operation_player_organization.contact_email, contact_name: @operation_player_organization.contact_name, contact_phone: @operation_player_organization.contact_phone, contact_position: @operation_player_organization.contact_position, name: @operation_player_organization.name, org_type: @operation_player_organization.org_type }
    assert_redirected_to operation_player_organization_path(assigns(:operation_player_organization))
  end

  test "should destroy operation_player_organization" do
    assert_difference('Operation::PlayerOrganization.count', -1) do
      delete :destroy, id: @operation_player_organization
    end

    assert_redirected_to operation_player_organizations_path
  end
end
