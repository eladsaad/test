Cinemadrive::Application.configure do

	config.action_mailer.default_url_options = { :host => ENV["HTTP_HOST"] }
	config.action_mailer.delivery_method = :smtp
	config.action_mailer.smtp_settings = {
	  :address              => ENV["SMTP_HOST"],
	  :port                 => ENV["SMTP_PORT"],
	  :domain               => ENV["SMTP_DOMAIN"],
	  :user_name            => ENV["SMTP_USERNAME"],
	  :password             => ENV["SMTP_PASSWORD"],
	  :authentication       => 'plain',
	  :enable_starttls_auto => true
	}

  end