class PlayerInvitesController < BaseController
  def invite
    authorize! :create, :invite
  end

  def send_invite
    authorize! :create, :invite
    current_player.invite_friend(params["friend_email"], params["message"])
    redirect_to root_url
  end
end