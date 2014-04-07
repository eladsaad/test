class Api::V1::InteractiveVideosController < Api::BaseApiController

	def index
		authorize! :index, InteractiveVideo
		@program_videos = current_player.current_online_program.online_program_interactive_videos
	end

	def show
		interactive_video = InteractiveVideo.find(params[:id])
		authorize! :read, interactive_video
		@program_video = current_player.current_online_program.online_program_interactive_videos.where(interactive_video_id: interactive_video.id).first
	end

end
