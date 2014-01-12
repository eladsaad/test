class Players::SessionsController < Devise::SessionsController

	# Audit player sign in
	def after_sign_in_path_for(player)
		if player.is_a?(Player) # just to verify
			# log player's sign-in
			player_session = PlayerSession.create!({
				player_id: current_player.id,
				sign_in_at: Time.now,
				ip_address: request.remote_ip,
				session_id: request.session_options[:id]
			});
			session[:player_session_id] = player_session.id
		end
		player_dashboard_path
	end

	# Audit player sign in
	def after_sign_out_path_for(player_symbol)
		if player_symbol == :player # just to verify
			# log player's sign-out
			session_id = session[:player_session_id]
			if session_id.nil?
				Rails.logger.error "No [player_session_id] stored in session"
			else
				player_session = PlayerSession.find(session[:player_session_id])
				if (player_session.nil?)
					Rails.logger.error "Cannot find PlayerSession with id [#{session[:player_session_id]}]"
				else
					player_session.update({sign_out_at: Time.now})
				end
				session.delete(:player_session_id)
			end
		end
		root_url
	end

end