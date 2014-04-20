class Api::V1::SessionsController < Api::BaseApiController

	skip_before_filter :authenticate_player_by_api_key!, only: [:create]
	skip_before_filter :verify_complete_player_registration, only: [:create, :destroy]
	skip_authorization_check :only => [:create]

	def create
	    player = Player.find_for_database_authentication(email: params[:email])
	 
	    if !player.nil? && player.valid_password?(params[:password])
			@player_api_key = PlayerApiKey.create!(player_id: player.id)
			sign_in player, store: false
			PlayerSession.add_login(current_player.id, request, @player_api_key.access_token)
	    else
	    	render_error(:invliad_login_credentials)
    	end
	  end

	def destroy
		authorize! :destroy, current_api_key
		sign_out current_player
		PlayerSession.add_logout(current_player.id, request, current_api_key.access_token)
		current_api_key.destroy!

	end

end