class UpdateCampaignMobileBannerFields < ActiveRecord::Migration
  def change

  	# remove old columns
  	remove_column :campaigns, :banner_mobile_01, :text
    remove_column :campaigns, :banner_mobile_02, :text
    remove_column :campaigns, :banner_mobile_03, :text
    remove_column :campaigns, :banner_mobile_04, :text
    remove_column :campaigns, :banner_mobile_05, :text
    remove_column :campaigns, :banner_mobile_06, :text
    remove_column :campaigns, :banner_mobile_07, :text
    remove_column :campaigns, :banner_mobile_08, :text
    remove_column :campaigns, :banner_mobile_09, :text
    remove_column :campaigns, :banner_mobile_10, :text

    # update website columns
    rename_column :campaigns, :banner_html_01, :website_banner_html_01
    rename_column :campaigns, :banner_html_02, :website_banner_html_02
    rename_column :campaigns, :banner_html_03, :website_banner_html_03
    rename_column :campaigns, :banner_html_04, :website_banner_html_04
    rename_column :campaigns, :banner_html_05, :website_banner_html_05
    rename_column :campaigns, :banner_html_06, :website_banner_html_06
    rename_column :campaigns, :banner_html_07, :website_banner_html_07
    rename_column :campaigns, :banner_html_08, :website_banner_html_08
    rename_column :campaigns, :banner_html_09, :website_banner_html_09
    rename_column :campaigns, :banner_html_10, :website_banner_html_10

    # add new column
    add_column :campaigns, :banner_image, :text

  end
end
