class Api::V1::CampaignsController < Api::BaseApiController

	def current
		@campaign = Campaign.get_by_player_group(current_player.player_group)
		@campaign.show_banner_image
		authorize! :read, @campaign
	end

	def click
		@campaign = Campaign.find(params.require(:id))
    	authorize! :click, @campaign
    	@campaign.click!
	end

end