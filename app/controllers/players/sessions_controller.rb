class Players::SessionsController < Devise::SessionsController

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

	# Audit player sign in
	def after_sign_in_path_for(player)

    if PlayerSession.find_by_player_id(current_player.id).nil?
      # first login
      # TODO: take from points rules table
      current_player.add_points(1000)
      flash[:points] = ["You just registered our website<br>and won extra" , '1000']
    end

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

		interactive_videos_path
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