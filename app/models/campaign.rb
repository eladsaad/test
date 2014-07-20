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
