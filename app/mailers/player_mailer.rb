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

end
