class PlayerMailer < ActionMailer::Base
  
	def custom_email(address, subject, content)
    puts ">>>>>>>>>>>>>>"
    p ENV['NOTIFICATION_MAIL_SENDER']
	    mail(
			to: address,
			from: ENV['NOTIFICATION_MAIL_SENDER'],
			body: content,
			content_type: "text/html",
			subject: subject
         )
  	end

end
