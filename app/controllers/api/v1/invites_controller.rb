class Api::V1::InvitesController < Api::BaseApiController

	def create
    authorize! :create, :invite
    @added_points = current_player.invite_friend(params["friend_email"],
                                          params["message"])
  end

end