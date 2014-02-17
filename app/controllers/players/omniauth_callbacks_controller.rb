class Players::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	
	def facebook
		@player = Player.find_for_facebook_oauth(request.env["omniauth.auth"], current_player)

		if @player.persisted? && @player.current_player_group
			#sign_in_and_redirect @player, :event => :authentication #this will throw if @player is not activated
			sign_in @player
			set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
			redirect_to player_dashboard_path
		else
			session["devise.facebook_data"] ||= {}
			session["devise.facebook_data"]["info"] ||= {}
			session["devise.facebook_data"]["extra"] ||= {}
			session["devise.facebook_data"]["extra"]["raw_info"] ||= {}
			session["devise.facebook_data"]["info"]["image"] = request.env["omniauth.auth"]["info"]["image"]
			session["devise.facebook_data"]["extra"]["raw_info"]["email"] = request.env["omniauth.auth"]["extra"]["raw_info"]["email"]
			session["devise.facebook_data"]["extra"]["raw_info"]["first_name"] = request.env["omniauth.auth"]["extra"]["raw_info"]["first_name"]
			session["devise.facebook_data"]["extra"]["raw_info"]["last_name"] = request.env["omniauth.auth"]["extra"]["raw_info"]["last_name"]
			session["devise.facebook_data"]["extra"]["raw_info"]["gender"] = request.env["omniauth.auth"]["extra"]["raw_info"]["gender"]
			session["devise.facebook_data"]["extra"]["raw_info"]["birthday"] = request.env["omniauth.auth"]["extra"]["raw_info"]["birthday"]

			# session["devise.facebook_data"] = request.env["omniauth.auth"]
			redirect_to new_player_registration_path(reg_code: request.env["omniauth.params"]['reg_code'])
		end
	end

end