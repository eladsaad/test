class PlayerInvitesController < BaseController
  def invite
    authorize! :create, :invite
  end

  def send_invite
    authorize! :create, :invite

    points = current_player.invite_friend(params["friend_email"],
                                 params["message"])

    flash[:points] = ["For inviting a friend<br>you get extra" , points]

    redirect_to '/'

    #respond_to do |format|
    #    format.html { render "invite" }
    #    format.js   { render "invite" }
    #end
  end
end