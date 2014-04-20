class PlayerInviteController < BaseController
  def invite
    authorize! :send, :invite
  end

  def send_invite
    authorize! :send, :invite

    PlayerMailer.custom_email(params["friend_email"], current_player.first_name + " invited you to join Cinema-Drive!",
                              params["message"]).deliver

    #flash[:notice] = "Thank you!"
    current_player.add_points(2500, :friend_invite)

    redirect_to root_url
  end
end