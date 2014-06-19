class PlayerMailer < ActionMailer::Base
  
	def custom_email(address, subject, content)
	    mail(
			to: address,
			from: ENV['NOTIFICATION_MAIL_SENDER'],
			body: content,
			content_type: "text/html",
			subject: subject
         )
  end

  def invite_email(friend_email, first_name, message)
    self.custom_email(friend_email, first_name + " invited you to join Cinema-Drive!",
                      message).deliver
  end

end
