class Api::V1::InteractiveVideosController < Api::BaseApiController

	def index
		authorize! :index, InteractiveVideo
		@program_videos = current_player.current_online_program.online_program_interactive_videos
	end

	def show
		@program_video = current_player.current_online_program.online_program_interactive_videos.where(interactive_video_id: params[:id]).first
		authorize! :read, @program_video.interactive_video
	end

	def done
		@program_video = current_player.current_online_program.online_program_interactive_videos.where(interactive_video_id: params[:id]).first
		authorize! :read, @program_video.interactive_video
		@added_points = @program_video.watched_by!(current_player)
	end

end
