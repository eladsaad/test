@yielded_data = JSON.parse(yield)
if !@yielded_data.empty?
	json.data @yielded_data
end

if ScoreUpdate.updates.any?
	json.score do
		json.current current_player.score
		json.updates do
			json.array! ScoreUpdate.updates do |update|
			  json.action update[:action]
			  json.points update[:points]
			end
		end
	end
end