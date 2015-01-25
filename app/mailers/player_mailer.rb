class PlayerMailer < ActionMailer::Base
  
	def custom_email(address, subject, content)
	    content ||= ' ' # must not be nil
	    mail(
			to: address,
			from: ENV['NOTIFICATION_MAIL_SENDER'],
			body: content,
			content_type: "text/html",
			subject: subject
         )
  	end

  	def player_invitation(inviting_player, invited_email, custom_message)
  		p ENV['NOTIFICATION_MAIL_SENDER']
			@inviting_player = inviting_player
  		@reg_code = @inviting_player.player_group.reg_code
  		@invited_email = invited_email
  		@custom_message = custom_message
  		mail(
  			from: ENV['NOTIFICATION_MAIL_SENDER'],
  			to: @invited_email,
  			subject: I18n.t(:player_invitation_email_subject, inviting_player_name: @inviting_player.first_name)
  		)
	end

end
