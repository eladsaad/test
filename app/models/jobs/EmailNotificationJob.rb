class EmailNotificationJob

	def initialize(email_address, subject, content)
		@address = email_address
		@content = content
		@subject = subject
	end

	def perform
		Rails.logger.debug "Sending email to [#{@address}]"
    	PlayerMailer.custom_email(@address, @subject, @content).deliver
	end

end