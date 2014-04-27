class Api::V1::PasswordsController < Api::BaseApiController

	skip_before_filter :authenticate_player_by_api_key!, only: [:create, :update]
	skip_before_filter :verify_complete_player_registration, only: [:create, :update]
	skip_authorization_check :only => [:create, :update]

	
	def create
		CustomDeviseMailer.use_api_version!
		@player = Player.send_reset_password_instructions(reset_password_params)

		if @player.errors.any?
			render_error(:unprocessable_entity, @player.errors )
		end

	end

	def update
		@player = Player.reset_password_by_token(update_password_params)

		if @player.errors.any?
			render_error(:unprocessable_entity, @player.errors )
		end
	end	


	protected

		def reset_password_params
			require_and_permit(:email)
		end

		def update_password_params
			require_and_permit(
				:reset_password_token,
				:password,
				:password_confirmation
			)
		end

end