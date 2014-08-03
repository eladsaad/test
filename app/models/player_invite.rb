class PlayerInvite < ActiveRecord::Base

	# == VALIDATIONS ==
	validates_format_of :email, :with => /@/
	validates :inviting_player, :presence => true

	# == ASSOCIATIONS ==
	belongs_to :inviting_player, class_name: 'Player'

	# == HOOKS ==
	after_create :send_invite

	
	# == UTILS ==

	def self.player_registered!(invited_player)
		player_invites = PlayerInvite.where(email: invited_player.email, invited_player_id: nil)
		player_invites.pluck(:inviting_player_id).each do |inviting_player_id|
			Player.add_points(inviting_player_id, :invited_player_registered, {invited_player_email: invited_player.email})
		end
		player_invites.update_all(invited_player_id: invited_player.id)
	end

	protected

		def send_invite
			begin
				PlayerMailer.player_invitation(self.inviting_player, self.email, self.message).deliver
	        rescue Exception => e
	        	Rails.logger.info "Cannot send invite email to [#{self.email}] - #{e.message}"
        	end
		end

end
