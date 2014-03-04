class FacebookNotificationJob

	def initialize(facebook_user_id, content, callback_url)
		@facebook_user_id = facebook_user_id
		@content = content
		@callback_url = callback_url
	end

	def perform
		uri = URI.encode("https://graph.facebook.com/#{@facebook_user_id}/notifications")
		uri = URI.parse(uri)
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE

		fb_req = Net::HTTP::Post.new(uri.request_uri)
		fb_req.set_form_data(
			'access_token' => ENV['FACEBOOK_APP_ACCESS_TOKEN'],
			'href' => @callback_url,
			'template' => @content,
			)

		Rails.logger.info "Sending facebook notification to facebook user id [#{@facebook_user_id}]"
		Rails.logger.info "DOR #{ENV['FACEBOOK_APP_ACCESS_TOKEN']}"
		response = http.request(fb_req)

		if response.nil?
			raise "Cannot send notification to facebook user id [#{@facebook_user_id}]"
		elsif response.code != '200'
			raise "Error sending notification to facebook user id [#{@facebook_user_id}] - #{response.body}"
		end

		Rails.logger.debug response.to_yaml
		# TODO: investigate response ?
	end

end

