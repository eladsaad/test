class NotificationsController < BaseController

	before_filter :set_player_from_fb_signed_request, only: [:facebook]

	skip_before_filter :verify_authenticity_token, only: [:facebook]
	skip_before_filter :authenticate_player!, only: [:facebook]
	skip_before_filter :tos_accepted, only: [:facebook]


	def facebook
		@notification = Notification.find(params[:id])
		authorize! :read, @notification
		@notification_content = Notification.parse_text(@notification.facebook_content, current_player)
		render :layout => false
	end


	private

		def set_player_from_fb_signed_request
			# set current_player using facebook's signed_request parameter if not signed in
			unless player_signed_in?
				@current_player = PlayerAuthentication.get_player_from_facebook_signed_request(params['signed_request'])
				if (@current_player.blank?)
					raise ActionController::RoutingError.new('Not Found')
				end
			end
		end
end
