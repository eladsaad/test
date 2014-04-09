class Api::V1::SessionsController < Api::BaseApiController

	layout false

	skip_before_filter :authenticate_player_by_api_key!, only: [:create]
	skip_authorization_check :only => [:create]

	def create
	    player = Player.find_for_database_authentication(email: params[:email])
	    render_error(:invliad_login_credentials) unless player
	 
	    if player.valid_password?(params[:password])
	      sign_in player
	      @player_api_key = PlayerApiKey.create!(player_id: player.id)
	    else
	    	render_error(:invliad_login_credentials)
    	end
	  end


	def destroy
		authorize! :destroy, current_api_key
		sign_out current_player
		current_api_key.destroy!
	end

end