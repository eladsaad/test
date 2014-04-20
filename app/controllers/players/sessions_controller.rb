class Players::SessionsController < Devise::SessionsController

	after_filter :audit_player_login, only: [:create]
	before_filter :audit_player_logout, only: [:destroy]

	respond_to :html, :js

	def destroy
		signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
		respond_to do |format|
			format.html { super }
			format.js  {
				#redirect_to '/', status: 303
			}
		end
	end

	def after_sign_in_path_for(player)
		interactive_videos_path
	end

	def after_sign_out_path_for(player_symbol)
		root_url
	end

	# == Audit Login/Logout

	def audit_player_login
		if signed_in?
			PlayerSession.add_login(current_player.id, request, request.session_options[:id])
			session[:session_key] = request.session_options[:id]
			add_score_updates_to_flash
		end
	end

	def audit_player_logout
		PlayerSession.add_logout(current_player.id, request, session[:session_key])
		session.delete(:session_key)
	end

end