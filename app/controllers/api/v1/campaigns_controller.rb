class Api::V1::CampaignsController < Api::BaseApiController

	def current
		@campaign = Campaign.get_by_player_group(current_player.current_player_group)
		authorize! :read, @campaign
	end

	def click
		@campaign = Campaign.find(params.require(:id))
    	authorize! :click, @campaign
    	@campaign.click!
	end

end