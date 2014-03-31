class Api::BaseApiController < ApplicationController

  protect_from_forgery with: :null_session

  before_filter: authenticate_player_by_api_key!

  respond_to :json

  protected 

  	def authenticate_player_by_api_key!
		authenticate_or_request_with_http_token do |token, options|
			player_api_key = PlayerApiKey.where(access_token: token).first
			if player_api_key && !player_api_key.expired?
				sign_in player_api_key.player, store: false
				@current_api_key = player_api_key
		        true
			else
				false
			end
		end
	end

	def current_api_key
		@current_api_key
	end

end
