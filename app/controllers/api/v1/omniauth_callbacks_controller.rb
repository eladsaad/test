class Api::V1::OmniauthCallbacksController < Api::BaseApiController

	skip_before_filter :authenticate_player_by_api_key!, only: [:facebook]
	skip_before_filter :verify_authenticity_token, only: [:facebook]
	skip_before_filter :verify_complete_player_registration, only: [:facebook]
	skip_authorization_check :only => [:facebook]

	def facebook
		
		# # verify given signed_request
		# begin
		# 	signed_request = params.require(:signed_request)
		# 	koala_oauth = Koala::Facebook::OAuth.new(ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'])
		# 	signed_request_parsed = koala_oauth.parse_signed_request(signed_request)
		# rescue Koala::Facebook::OAuthSignatureError => e
		# 	render_error(:invalid_facebook_signed_request, e.message)
		# 	return
		# end

  		# get user data from facebook using the given access_token
  		begin
  			access_token = params.require(:access_token)
      		omnihash = get_omnihash_from_token(access_token)
      	rescue Koala::Facebook::APIError => e
      		render_error(:invalid_facebook_access_token, e.message)
      		return
  		end

      	# find player in database
      	player = Player.find_for_facebook_oauth(omnihash, current_player)

		# register via facebook if given required parameters
		if player.nil?
			if omnihash.extra.raw_info.email.blank?
				render_error(:missing_facebook_email)
				return
	  		end
			reg_code = params.require(:reg_code)
			tos_accepted = params.require(:tos_accepted)
			raise(ActionController::ParameterMissing.new(:reg_code)) if reg_code.blank?
			raise(ActionController::ParameterMissing.new(:tos_accepted)) unless tos_accepted
			player = Player.create_for_facebook_oauth(omnihash, reg_code, tos_accepted)

			unless player.save
				render_error(:unprocessable_entity, player.errors)
				return
			end
			player.reload
		end


		if player.try(:persisted?) && player.registration_complete?
			@player_api_key = PlayerApiKey.create!(player_id: player.id)
			sign_in player, store: false
		else
			player.destroy
			render_error(:unprocessable_entity)
		end
	end


	protected

		def get_omnihash_from_token(access_token)

			graph = Koala::Facebook::API.new(access_token, ENV['FACEBOOK_APP_SECRET'])
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

end