class ApiError

	def self.get(key)
		errors[key]
	end

	protected

	def self.errors
		{
			# general
			not_authenticated: { message: 'Not Authenticated', status: :unauthorized },
			not_found: { message: 'Not Found', status: :not_found },
			unprocessable_entity: { message: 'Unprocessable Entity', status: :unprocessable_entity },
			access_denied: { message: 'Access Denied', status: :forbidden },
			incomplete_registration: { message: 'Incomplete Registration', status: :forbidden },
			missing_parameter: { message: 'Missing Parameter', status: :unprocessable_entity },
			
			# authentication
			invliad_login_credentials: { message: 'Invalid Credentials', status: :unauthorized },

			# interactive videos
			missing_pre_survey: { message: 'Missing Pre Survey', status: :forbidden },
			missing_post_survey: { message: 'Missing Post Survey', status: :forbidden },

			# facebook
			missing_facebook_email: { message: 'Missing Facebook Email', status: :unprocessable_entity },
			invalid_facebook_authentication: { message: 'Invalid Facebook Authentication', status: :unprocessable_entity },
			invalid_facebook_signed_request: { message: 'Invalid Facebook Signed Request', status: :unprocessable_entity },
			invalid_facebook_access_token: { message: 'Invalid Facebook Access Token', status: :unprocessable_entity },
		}
	end

	

end