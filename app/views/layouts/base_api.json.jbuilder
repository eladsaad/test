@yielded_data = JSON.parse(yield)
if !@yielded_data.empty?
	json.data @yielded_data
end
if @added_points
	json.score do
		json.score current_player.score
		json.added_points @added_points
	end
end