class NotificationsController < BaseController

	skip_before_filter :verify_authenticity_token, only: [:facebook]
	skip_before_filter :authenticate_player!, only: [:facebook]
	skip_before_filter :tos_accepted, only: [:facebook]
	skip_authorization_check :only => [:facebook]

	def facebook
		# @notification = Notification.find(params[:id])
		# authorize! :read, @notification
		# @notification_content = Notification.parse_text(@notification.facebook_content, current_player)
		render :layout => false
	end

end
