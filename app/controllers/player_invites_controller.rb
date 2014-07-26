class PlayerInvitesController < BaseController
  def invite
    authorize! :create, :invite
  end

  def send_invite
    authorize! :create, :invite
    @player_invite = PlayerInvite.new(player_invite_params)
	@player_invite.inviting_player_id = current_player.id
	@player_invite.save
	redirect_to root_url
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