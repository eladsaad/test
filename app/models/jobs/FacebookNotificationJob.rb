class FacebookNotificationJob < Struct.new(:player_id, :content, :callback_url)
  def perform
  	# get player
    player = Player.find(self.player_id)
    if player.blank?
    	raise "Cannot find player with id [#{self.player_id}]"
	else
		# send notification
		response = player.send_facebook_notifications(self.content, self.callback_url)
		if response.nil?
			raise "Cannot send notification for player id [#{self.player_id}]"
		end
		# TODO: investigate response ?
	end
  end
end