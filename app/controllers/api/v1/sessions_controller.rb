class Api::V1::SessionsController < Api::BaseApiController

	skip_before_filter :authenticate_player_by_api_key!, only: [:create]


	def create
	    player = Player.find_for_database_authentication(email: params[:email])
	    return invalid_login_attempt unless player
	 
	    if player.valid_password?(params[:password])
	      sign_in player
	      player_api_key = PlayerApiKey.new(player_id: player.id)

	      render :json => {
	      	:success => true,
	      	:authentication_token => player_api_key.access_token,
	      	:email => resource.email
	      }
	      # TODO: jbuilder
	      return
	    end

	    invalid_login_attempt
	  end


	def destroy
		sign_out current_player
		current_api_key.destroy!
		render :json=> {:success=>true}
	end


	protected

		def invalid_login_attempt
			#TODO: jbuilder
			render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
		end

end