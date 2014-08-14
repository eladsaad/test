class Api::V1::ScoresController < Api::BaseApiController

	def index
		authorize! :index, Score
	    @player_score = current_player.score
	    @group_score = current_player.player_group.score
	end

end