class Campaign < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :name, :presence => true
	validates :max_views, :numericality => { :greater_than => 0 }, allow_blank: true

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

		self.where(id: allowed_campaigns).where("views < max_views").first
		# TODO: what to do if no banner is available ?
	end

	def show_banner_content(banner_number)
		content = self.send("banner_html_#{banner_number}")
		self.views += 1
		self.save!
		return content
	end

end
