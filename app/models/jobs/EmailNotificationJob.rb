class EmailNotificationJob

	def initialize(email_address, content)
		@address = email_address
		@content = content
		@subject = '' #TODO: ????
	end

	def perform
		Rails.logger.info "Sending email to [#{@address}]"
    	PlayerMailer.custom_email(@address, @subject, @content).deliver
	end

end