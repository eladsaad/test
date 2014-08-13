class Api::V1::InteractiveVideosController < Api::BaseApiController

	before_filter :set_program_video, only: [:show, :done]
	before_action :check_for_pre_survey, only: [:show]
 	before_action :check_for_post_survey, only: [:done]

	def index
		authorize! :index, InteractiveVideo
		@program_videos = current_player.current_online_program.online_program_interactive_videos
	end

	def show
		authorize! :read, @program_video.interactive_video
	end

	def done # post_interactive
		authorize! :read, @program_video.interactive_video
		@program_video.watched_by!(current_player)
	end

	protected

	def set_program_video
		@program_video = current_player.current_online_program.online_program_interactive_videos.where(interactive_video_id: params.require(:id)).first
		render_error(:not_found) unless !@program_video.nil?
	end

	def check_for_pre_survey
		pre_survey_id = @program_video.external_pre_survey_id
		if !pre_survey_id.blank? && !PlayerAnswer.find_by_player_and_external_survey_id(current_player, pre_survey_id).any?
			render_error(:missing_pre_survey)		 
		end
	end

	def check_for_post_survey
		post_survey_id = @program_video.external_post_survey_id
		if !post_survey_id.blank? && !PlayerAnswer.find_by_player_and_external_survey_id(current_player, post_survey_id).any?
			render_error(:missing_post_survey)		
		end
	end

end
