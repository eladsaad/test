json.data JSON.parse(yield)
if @added_points
	json.score do
		json.score current_player.score
		json.added_points @added_points
	end
end