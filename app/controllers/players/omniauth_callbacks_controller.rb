class Players::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  respond_to :html, :js

	def facebook
		@player = Player.find_for_facebook_oauth(request.env["omniauth.auth"], current_player, request.env["omniauth.params"]['reg_code'])
		if @player.try(:persisted?)
			sign_in @player
			if @player.tos_accepted
				set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
				redirect_to interactive_videos_path
			else
				redirect_to edit_accept_tos_player_path
			end
		else
			flash[:alert] = 'Cannot sign-up via facebook'
			redirect_to new_player_registration_path(reg_code: request.env["omniauth.params"]['reg_code'])
		end
	end

end