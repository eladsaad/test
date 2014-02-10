require 'test_helper'

class Admin::CampaignsControllerTest < ActionController::TestCase
  setup do
    @admin_campaign = admin_campaigns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_campaigns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_campaign" do
    assert_difference('Admin::Campaign.count') do
      post :create, admin_campaign: { banner_html_01: @admin_campaign.banner_html_01, banner_html_02: @admin_campaign.banner_html_02, banner_html_03: @admin_campaign.banner_html_03, banner_html_04: @admin_campaign.banner_html_04, banner_html_05: @admin_campaign.banner_html_05, banner_html_06: @admin_campaign.banner_html_06, banner_html_07: @admin_campaign.banner_html_07, banner_html_08: @admin_campaign.banner_html_08, banner_html_09: @admin_campaign.banner_html_09, banner_html_10: @admin_campaign.banner_html_10, clicks: @admin_campaign.clicks, landing_page: @admin_campaign.landing_page, max_views: @admin_campaign.max_views, name: @admin_campaign.name, trophy_name: @admin_campaign.trophy_name, views: @admin_campaign.views }
    end

    assert_redirected_to admin_campaign_path(assigns(:admin_campaign))
  end

  test "should show admin_campaign" do
    get :show, id: @admin_campaign
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_campaign
    assert_response :success
  end

  test "should update admin_campaign" do
    patch :update, id: @admin_campaign, admin_campaign: { banner_html_01: @admin_campaign.banner_html_01, banner_html_02: @admin_campaign.banner_html_02, banner_html_03: @admin_campaign.banner_html_03, banner_html_04: @admin_campaign.banner_html_04, banner_html_05: @admin_campaign.banner_html_05, banner_html_06: @admin_campaign.banner_html_06, banner_html_07: @admin_campaign.banner_html_07, banner_html_08: @admin_campaign.banner_html_08, banner_html_09: @admin_campaign.banner_html_09, banner_html_10: @admin_campaign.banner_html_10, clicks: @admin_campaign.clicks, landing_page: @admin_campaign.landing_page, max_views: @admin_campaign.max_views, name: @admin_campaign.name, trophy_name: @admin_campaign.trophy_name, views: @admin_campaign.views }
    assert_redirected_to admin_campaign_path(assigns(:admin_campaign))
  end

  test "should destroy admin_campaign" do
    assert_difference('Admin::Campaign.count', -1) do
      delete :destroy, id: @admin_campaign
    end

    assert_redirected_to admin_campaigns_path
  end
end
