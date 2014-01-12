class PlayersController < BaseController

  # GET /players/dashboard
  def dashboard
    authorize! :read, :player_dashboard
    # TODO: implement

    # # Example code for using facebook graph api with the koala gem
    # @token = current_player.get_token(:facebook)
    # if (@token)
	#     @graph = Koala::Facebook::API.new(current_player.get_token(:facebook))

	# 	@profile = @graph.get_object("me")
	# 	@profile_pic = @graph.get_picture("me", type: 'square')
	# 	@friends = @graph.get_connections("me", "friends")
	# 	@feed = @graph.get_connections("me", "feed")
	# end

  end

end
