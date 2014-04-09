class ApiError

	def self.get(key)
		errors[key]
	end

	protected

	def self.errors
		{
			not_authenticated: { message: 'Not Authenticated', status: :unauthorized },
			invliad_login_credentials: { message: 'Invalid Credentials', status: :unauthorized },
			not_found: { message: 'Not Found', status: :not_found},
			missing_pre_survey: { message: 'Missing Pre Survey', status: :forbidden },
			missing_post_survey: { message: 'Missing Post Survey', status: :forbidden },
			incomplete_registration: { message: 'Incomplete Registration', status: :forbidden },
		}
	end

	

end