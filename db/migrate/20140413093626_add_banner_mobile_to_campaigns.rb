class AddBannerMobileToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :banner_mobile_01, :string
    add_column :campaigns, :banner_mobile_02, :string
    add_column :campaigns, :banner_mobile_03, :string
    add_column :campaigns, :banner_mobile_04, :string
    add_column :campaigns, :banner_mobile_05, :string
    add_column :campaigns, :banner_mobile_06, :string
    add_column :campaigns, :banner_mobile_07, :string
    add_column :campaigns, :banner_mobile_08, :string
    add_column :campaigns, :banner_mobile_09, :string
    add_column :campaigns, :banner_mobile_10, :string
  end
end
