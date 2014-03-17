class NotificationsController < BaseController

	skip_before_filter :verify_authenticity_token, only: [:facebook]

	def facebook
		@notification = Notification.find(params[:id])
		authorize! :read, @notification
		@notification_content = Notification.parse_text(@notification.facebook_content, current_player)
		render :layout => false
	end

end
