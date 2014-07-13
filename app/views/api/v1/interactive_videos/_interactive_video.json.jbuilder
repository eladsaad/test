json.extract! program_video.interactive_video, :id, :name, :description
if can? :read, program_video.interactive_video
	json.extract! program_video.interactive_video, :content, :content_mobile
end
json.partial! 'program_video_surveys', program_video: program_video
json.enabled program_video.enabled_for_group?(current_player.current_player_group)
json.watched program_video.watched?(current_player)
json.enabled_from program_video.enabled_time(current_player.current_player_group)