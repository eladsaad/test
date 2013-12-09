require 'test_helper'

class PlayerOrganizationsControllerTest < ActionController::TestCase
  setup do
    @player_organization = player_organizations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:player_organizations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create player_organization" do
    assert_difference('PlayerOrganization.count') do
      post :create, player_organization: { address: @player_organization.address, contact_email: @player_organization.contact_email, contact_name: @player_organization.contact_name, contact_phone: @player_organization.contact_phone, contact_position: @player_organization.contact_position, name: @player_organization.name, org_type: @player_organization.org_type }
    end

    assert_redirected_to player_organization_path(assigns(:player_organization))
  end

  test "should show player_organization" do
    get :show, id: @player_organization
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @player_organization
    assert_response :success
  end

  test "should update player_organization" do
    patch :update, id: @player_organization, player_organization: { address: @player_organization.address, contact_email: @player_organization.contact_email, contact_name: @player_organization.contact_name, contact_phone: @player_organization.contact_phone, contact_position: @player_organization.contact_position, name: @player_organization.name, org_type: @player_organization.org_type }
    assert_redirected_to player_organization_path(assigns(:player_organization))
  end

  test "should destroy player_organization" do
    assert_difference('PlayerOrganization.count', -1) do
      delete :destroy, id: @player_organization
    end

    assert_redirected_to player_organizations_path
  end
end
