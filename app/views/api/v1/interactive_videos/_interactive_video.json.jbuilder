json.extract! program_video.interactive_video, :id, :name, :description, :thumbnail_url, :thumbnail_disabled_url
if can? :read, program_video.interactive_video
	json.extract! program_video.interactive_video, :content, :content_mobile
end
json.partial! 'program_video_surveys', program_video: program_video
json.enabled program_video.enabled_for_player?(current_player)
json.watched program_video.watched?(current_player)
enabled_time = program_video.enabled_time(current_player.player_group)
json.available_at enabled_time
json.available_at_text enabled_time_message(enabled_time)