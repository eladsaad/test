class DownloadFacebookImageJob

  require "open-uri"

	def initialize(player_id, image_url)
		@player = Player.find(player_id)
		@image_url = image_url
	end

	def perform
		Rails.logger.debug "Download image for player id: #{@player.id} , image url: #{@image_url}"
    @player.avatar = HTTParty.get(@image_url+"?type=square")
    @player.save
	end

end