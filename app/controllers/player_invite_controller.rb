class PlayerInviteController < BaseController
  def invite
    authorize! :send, :invite
  end

  def send_invite
    authorize! :send, :invite

    PlayerMailer.custom_email(params["friend_email"], current_player.first_name + " invited you to join Cinema-Drive!",
                              params["message"]).deliver

    flash[:notice] = "Thank you!"

    redirect_to '/'#, notice: "Thank you!"
    #respond_to do |format|
    #    format.html { render "invite" }
    #    format.js   { render "invite" }
    #end
  end
end