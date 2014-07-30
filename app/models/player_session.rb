class PlayerSession < ActiveRecord::Base

	# == ASSOCIATIONS ==
	belongs_to :player

	def self.add_login(player_id, request, session_key)

		first_login_points = PlayerSession.where(player_id: player_id).size == 0
		
		existing_session = PlayerSession.where(player_id: player_id, session_id: session_key).where('sign_in_at is not null')

		if existing_session.size == 0
			new_session = self.create!({
				player_id: player_id,
				sign_in_at: Time.now,
				ip_address: request.remote_ip,
				session_id: session_key
			})
		end

		if first_login_points
			new_session.player.add_points(:first_login, {player_session_id: new_session.id})
		end
	end


	def self.add_logout(player_id, request, session_key)
		self.create!({
			player_id: player_id,
			sign_out_at: Time.now,
			ip_address: request.remote_ip,
			session_id: session_key
		})
	end

end
