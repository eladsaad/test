class Api::V1::InvitesController < Api::BaseApiController

	def create
		authorize! :create, :invite
		@player_invite = PlayerInvite.new(player_invite_params)
		@player_invite.inviting_player_id = current_player.id
		unless @player_invite.save
			render_error(:unprocessable_entity, @player_invite.errors )
			return
		end
	end


	protected

		def player_invite_params
			params.permit(
		        :email,
				:message,
				:friend_type
	      	)
		end

end