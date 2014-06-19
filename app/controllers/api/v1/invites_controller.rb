class Api::V1::InvitesController < Api::BaseApiController

	def create
		authorize! :create, :invite
		current_player.invite_friend(params.require(:email), params.permit(:message)[:message])
	end

end