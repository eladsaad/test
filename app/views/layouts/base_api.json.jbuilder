@yielded_data = JSON.parse(yield)
if !@yielded_data.empty?
	json.data @yielded_data
end

@score_updates = PlayerScoreUpdate.unreported(current_player.id)
if @score_updates.any?
	json.score do
		json.current current_player.score
		json.updates do
			json.array! @score_updates do |update|
			  json.action update.event
			  json.points update.points
			  json.message update.message
			end
		end
	end
end
PlayerScoreUpdate.mark_reported!(@score_updates)