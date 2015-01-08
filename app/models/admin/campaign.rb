# == Schema Information
#
# Table name: campaigns
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  max_views              :integer
#  views                  :integer          default(0)
#  clicks                 :integer          default(0)
#  trophy_name            :string(255)
#  landing_page           :string(1000)
#  website_banner_html_01 :text
#  website_banner_html_02 :text
#  website_banner_html_03 :text
#  website_banner_html_04 :text
#  website_banner_html_05 :text
#  website_banner_html_06 :text
#  website_banner_html_07 :text
#  website_banner_html_08 :text
#  website_banner_html_09 :text
#  website_banner_html_10 :text
#  created_at             :datetime
#  updated_at             :datetime
#  banner_image           :text
#

class Admin::Campaign < Campaign
end
