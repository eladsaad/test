# == Schema Information
#
# Table name: player_authentications
#
#  id           :integer          not null, primary key
#  player_id    :integer
#  provider     :string(255)
#  uid          :string(255)
#  token        :string(255)
#  token_secret :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class PlayerAuthentication < ActiveRecord::Base

	# == ASSOCIATIONS ==
	belongs_to :player

	def self.get_player_from_facebook_signed_request(signed_request)		
		fb_data = self.parse_facebook_signed_request(signed_request)
		return if fb_data.blank?
		fb_user_id = fb_data['user_id']
		return if fb_user_id.blank?
		authentication = PlayerAuthentication.find_by_provider_and_uid(:facebook, fb_user_id)
		return if authentication.blank?
		return authentication.player
	end


	protected

		def self.parse_facebook_signed_request(signed_request)
			return if signed_request.blank?
			# We only care about the data after the '.'
			payload = signed_request.split(".")[1]
			# Facebook gives us a base64URL encoded string. Ruby only supports base64 out of the box, so we have to add padding to make it work
			payload += '=' * (4 - payload.length.modulo(4))
			decoded_json = Base64.decode64(payload)
			return JSON.parse(decoded_json)
		end 

end
