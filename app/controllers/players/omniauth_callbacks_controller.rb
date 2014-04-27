class Players::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  	after_filter :audit_player_login, only: [:facebook]

  	respond_to :html, :js

	def facebook
		@player = Player.find_for_facebook_oauth(request.env["omniauth.auth"], current_player)
		
		if @player.nil?
			@player = Player.create_for_facebook_oauth(request.env["omniauth.auth"], request.env["omniauth.params"]['reg_code'])
			@player.save(validate: false)
			@player.reload
		end

		if @player.try(:persisted?)
			sign_in @player
			if @player.registration_complete?
				set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
				redirect_to interactive_videos_path
			else
				redirect_to edit_player_registration_path
			end
		else
			flash[:alert] = 'Cannot sign-up via facebook'
			redirect_to new_player_registration_path(reg_code: request.env["omniauth.params"]['reg_code'])
		end
	end


	def audit_player_login
		if signed_in? && current_player.registration_complete?
			PlayerSession.add_login(current_player.id, request, request.session_options[:id])
			session[:session_key] = request.session_options[:id]
			add_score_updates_to_flash
		end
	end

end