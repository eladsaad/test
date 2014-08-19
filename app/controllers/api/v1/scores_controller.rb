class Api::V1::ScoresController < Api::BaseApiController

	def index
		authorize! :read, current_player
	    @player_score = current_player.score
	    @group_score = current_player.player_group.score
	end

end