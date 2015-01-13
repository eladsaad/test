class DownloadFacebookImageJob

  require "open-uri"

	def initialize(player_id, image_url)
		@player = Player.find(player_id)
		@image_url = image_url
	end

	def perform
    p "Download image for player id: #{@player.id} , image url: #{@image_url}"
    @player.avatar = open(@image_url)

    @player.save
	end

end