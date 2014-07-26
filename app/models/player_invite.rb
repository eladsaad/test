class PlayerInvite < ActiveRecord::Base

	# == VALIDATIONS ==
	validates_format_of :email, :with => /@/
	validates :inviting_player, :presence => true

	# == ASSOCIATIONS ==
	belongs_to :inviting_player, class_name: 'Player'

	# == HOOKS ==
	after_create :send_invite

	
	# == UTILS ==

	protected

		def send_invite
			begin
				PlayerMailer.custom_email(
					self.email,
					I18n.t(:player_invited_you_to_join, player_name: self.inviting_player.first_name),
					self.message
		        ).deliver
	        rescue Exception => e
	        	Rails.logger.info "Cannot send invite email to [#{self.email}] - #{e.message}"
        	end

		    self.inviting_player.add_points(2500, :friend_invite)
		end

end
