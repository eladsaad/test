class PlayerSession < ActiveRecord::Base

	# == ASSOCIATIONS ==
	belongs_to :player

	def self.add_login(player_id, request, session_key)

		first_login_points = PlayerSession.where(player_id: player_id).size == 0

		new_session = self.create!({
			player_id: player_id,
			sign_in_at: Time.now,
			ip_address: request.remote_ip,
			session_id: session_key
		});

		if first_login_points
			new_session.player.add_points(:first_login, {player_session_id: new_session.id})
		end
	end


	def self.add_logout(player_id, request, session_key)
		player_session = PlayerSession.find_by_session_id(session_key)
		if (player_session.nil?)
			Rails.logger.error "Cannot find PlayerSession with session id [#{session_key}]"
		else
			player_session.update({sign_out_at: Time.now})
		end
	end

end
