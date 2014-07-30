class Api::V1::SessionsController < Api::BaseApiController

	skip_before_filter :authenticate_player_by_api_key!, only: [:create]
	skip_before_filter :verify_complete_player_registration, only: [:create, :destroy]
	skip_authorization_check :only => [:create]

	def create
	    player = Player.find_for_database_authentication(email: params.require(:email))
	 
	    if !player.nil? && player.valid_password?(params.require(:password))
			@player_api_key = PlayerApiKey.create!(player_id: player.id)
			sign_in_api_key(@player_api_key)
	    else
	    	render_error(:invliad_login_credentials)
    	end
	  end

	def destroy
		authorize! :destroy, current_api_key
		player_id = current_player.id
		sign_out_api_key current_api_key
		current_api_key.destroy!
	end

end