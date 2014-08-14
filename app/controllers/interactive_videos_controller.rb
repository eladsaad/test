class InteractiveVideosController < BaseController

  before_action :set_interactive_video, only: [:show, :content, :post_interactive]
  before_action :check_for_pre_survey, only: [:show]
  before_action :check_for_post_survey, only: [:post_interactive]

  def index
    authorize! :index, InteractiveVideo
    @interactive_videos = current_player.current_online_program.online_program_interactive_videos.order(:start_after_days)
    @last_watched_index = current_player.player_progress.last_interactive_video_index
    @last_enabled_index = current_player.current_online_program.enabled_interactive_videos(current_player.player_group).size

    # get availability time of the next video

    @current_online_program = current_player.current_online_program
    @current_player_group = current_player.player_group
  end

  def show
    authorize! :read, @interactive_video
    #render :layout => false
  end

  def content
    authorize! :read, @interactive_video
    render :text => InteractiveVideo.parse_text(@interactive_video.content, current_player), :content_type => Mime::XML
  end

  def post_interactive
    authorize! :read, @interactive_video
    program_video = current_player.current_online_program.online_program_interactive_videos.where(interactive_video_id: @interactive_video.id).first
    program_video.watched_by!(current_player)
    redirect_to root_url
  end
  

  private


  def set_interactive_video
    @program_video = current_player.current_online_program.online_program_interactive_videos.where(interactive_video_id: params[:id]).first
    @interactive_video = @program_video.interactive_video
  end


  def check_for_pre_survey
    pre_survey_id = @program_video.external_pre_survey_id
    if !pre_survey_id.blank? && !PlayerAnswer.find_by_player_and_external_survey_id(current_player, pre_survey_id).any?
      redirect_to survey_url(id: pre_survey_id, post_survey: interactive_video_url(@interactive_video) )   
    end
  end

  def check_for_post_survey
    post_survey_id = @program_video.external_post_survey_id
    if !post_survey_id.blank? && !PlayerAnswer.find_by_player_and_external_survey_id(current_player, post_survey_id).any?
      redirect_to survey_url(id: post_survey_id, post_survey: post_interactive_interactive_video_path(params[:id]) ) 
    end
  end

end
