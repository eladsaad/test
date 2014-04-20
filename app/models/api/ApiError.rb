class ApiError

	def self.get(key)
		errors[key]
	end

	protected

	def self.errors
		{
			not_authenticated: { message: 'Not Authenticated', status: :unauthorized },
			invliad_login_credentials: { message: 'Invalid Credentials', status: :unauthorized },
			not_found: { message: 'Not Found', status: :not_found },
			unprocessable_entity: { message: 'Unprocessable Entity', status: :unprocessable_entity },
			access_denied: { message: 'Access Denied', status: :forbidden },
			missing_pre_survey: { message: 'Missing Pre Survey', status: :forbidden },
			missing_post_survey: { message: 'Missing Post Survey', status: :forbidden },
			incomplete_registration: { message: 'Incomplete Registration', status: :forbidden },
			survey_already_answered: { message: 'Survey Already Answered', status: :unprocessable_entity }
		}
	end

	

end