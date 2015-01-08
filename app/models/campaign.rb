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

class Campaign < ActiveRecord::Base

	MAX_VIEWS_VALUE_FOR_DEFAULT_CAMPAIGN = -1

	# == VALIDATIONS ==
	validates :name, :presence => true
	validates :max_views, :numericality => { :greater_than => -2 }, allow_blank: true

	# == ASSOCIATIONS ==
	has_many :campaign_operator_programs, :inverse_of => :campaign, :dependent => :destroy
	accepts_nested_attributes_for :campaign_operator_programs, allow_destroy: true, reject_if: :all_blank

	# == SEARCH ==
	search_columns [:name]

	# == METHODS ==

	def self.get_by_player_group(player_group)
		allowed_campaigns = CampaignOperatorProgram.where(
				operator_id: player_group.operator_id,
				online_program_id: player_group.online_program_id
			).pluck(:campaign_id)

		campaign = self.where(id: allowed_campaigns).where("views < max_views").first
		campaign ||= self.get_default # default campaign if none found
	end

	def show_website_banner_content(banner_number)
		content = self.send("website_banner_html_#{banner_number}")
		self.views += 1
		self.save!
		return content
	end

	def show_banner_image
		self.views += 1
		self.save!
	end

	def self.get_default
		self.where(max_views: MAX_VIEWS_VALUE_FOR_DEFAULT_CAMPAIGN).first
	end

	def click!
		self.clicks += 1
    	self.save!
	end

end
