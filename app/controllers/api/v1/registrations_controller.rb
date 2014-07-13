class Api::V1::RegistrationsController < Api::BaseApiController

	skip_before_filter :authenticate_player_by_api_key!, only: [:create]
	skip_before_filter :verify_complete_player_registration, only: [:create]
	skip_authorization_check :only => [:create]

	def create
		@player = Player.new(sign_up_params)
		@player.skip_confirmation!
		unless @player.save
			render_error(:unprocessable_entity, @player.errors )
		end
		@player.reload
	end

	def current
		@player = current_player
		authorize! :read, @player		
	end

	protected

		def sign_up_params
			params.permit(
		        :username,
				:email,
				:password,
				:first_name,
				:last_name,
				:birth_date,
				:gender,
				:age,
				:reg_code,
				:tos_accepted,
	      	)
		end

end