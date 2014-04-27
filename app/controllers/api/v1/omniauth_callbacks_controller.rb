class Api::V1::OmniauthCallbacksController < Api::BaseApiController

	skip_before_filter :authenticate_player_by_api_key!, only: [:facebook]
	skip_before_filter :verify_authenticity_token, only: [:facebook]
	skip_before_filter :verify_complete_player_registration, only: [:facebook]
	skip_authorization_check :only => [:facebook]


	def get_omnihash_from_token(access_token)

		graph = Koala::Facebook::API.new(access_token)
		profile = graph.get_object('me')

		# Generate omnihash
		omnihash = OpenStruct.new
		omnihash.provider = :facebook
		omnihash.uid = profile['id']

		omnihash.extra = OpenStruct.new
		omnihash.extra.raw_info = OpenStruct.new
		omnihash.extra.raw_info.email = profile['email']
		omnihash.extra.raw_info.first_name = profile['first_name']
		omnihash.extra.raw_info.last_name = profile['last_name']
		omnihash.extra.raw_info.gender = profile['gender']
		omnihash.extra.raw_info.birthday = profile['birthday']

		omnihash.info = OpenStruct.new
		omnihash.info.image = graph.get_picture('me')

		omnihash.credentials = OpenStruct.new
		omnihash.credentials.token = access_token

		return omnihash
	end


	def facebook
		
		auth_response = params.require(:auth_response)

		# get user data from facebook
		koala_oauth = Koala::Facebook::OAuth.new(ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'])	
      	signed_request_parsed = koala_oauth.parse_signed_request(auth_response[:signedRequest]) # verify signed_request
      	access_token = auth_response[:accessToken]
      	omnihash = get_omnihash_from_token(access_token)

      	# find player in database
      	player = Player.find_for_facebook_oauth(omnihash, current_player)

		# register via facebook if given required parameters
		if player.nil?
			if omnihash.extra.raw_info.email.blank?
	      		raise ActionController::ParameterMissing.new(:facebook_user_email)
	  		end
			reg_code = params.require(:reg_code)
			tos_accepted = params.require(:tos_accepted)
			raise(ActionController::ParameterMissing.new(:reg_code)) if reg_code.blank?
			raise(ActionController::ParameterMissing.new(:tos_accepted)) unless tos_accepted
			player = Player.create_for_facebook_oauth(omnihash, reg_code, tos_accepted)

			unless player.save
				render_error(:unprocessable_entity, player.errors )
				return
			end
			player.reload
		end


		if player.try(:persisted?) && player.registration_complete?
			@player_api_key = PlayerApiKey.create!(player_id: player.id)
			sign_in player, store: false
			PlayerSession.add_login(current_player.id, request, @player_api_key.access_token)
		else
			render json: {
				persisted: player.try(:persisted?),
				complete: player.registration_complete?,
				player: player,
				group: player.current_player_group
			}
			player.destroy
			return
			render_error(:unprocessable_entity)
		end
	end

end