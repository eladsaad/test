class InteractiveVideosController < BaseController
  before_action :set_interactive_video, only: [:show, :content, :post_interactive]
  before_action :check_for_pre_survey, only: [:show]

  before_action :check_for_post_survey, only: [:post_interactive]

  def index
    authorize! :index, InteractiveVideo
    @interactive_videos = current_player.current_online_program.online_program_interactive_videos.order(:start_after_days)
    @last_watched_index = current_player.current_progress.last_interactive_video_index
    @last_enabled_index = current_player.current_online_program.enabled_interactive_videos(current_player.current_player_group).size

    # get availability time of the next video

    @current_online_program = current_online_program
    @current_player_group = current_player_group
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

    # update player's progress
    progress = current_player.current_progress
    current_video_index = @interactive_video.index_in_program(current_player.current_online_program)
    if (progress.last_interactive_video_index < current_video_index)
      progress.last_interactive_video_index = current_video_index
      progress.save!
    end

    # check how far from the opening time the user watched the video
    seconds_diff = (Time.now - OnlineProgramInteractiveVideo.interactive_available_time(current_online_program.id,
                                                          @interactive_video.id,
                                                          current_player_group.screening_date)).to_i
    hours_diff = seconds_diff / 3600
    if (hours_diff > 24 ) # TODO: make hours diff threshold configurable
      current_player.add_points(1000) # TODO: make configurable
      flash[:points] = ["You just watched an episode<br>and won extra" , '1000']
    else
      current_player.add_points(3000) # TODO: make configurable
      flash[:points] = ["You just watched an episode<br>and won extra" , '3000']
    end

    redirect_to root_url
  end
  

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_interactive_video
    @interactive_video = InteractiveVideo.find(params[:id])
    #check_for_pre_survey
  end

  def check_for_pre_survey
    pre_survey = Survey.all.joins(
        'join online_program_interactive_videos on surveys.id = online_program_interactive_videos.pre_survey_id').
        where('online_program_interactive_videos.id = ?', @interactive_video.id).first

    if pre_survey != nil
      player_answer =  PlayerAnswer.where("player_group_id = ? AND player_id = ? AND survey_id = ?",
                         current_player_group.id, current_player.id, pre_survey.id).first

      if player_answer == nil
        # user didn't take this survey
        redirect_to polymorphic_path(pre_survey) + "?post_survey=" + polymorphic_path(@interactive_video)
      end
    end

    #current_online_program.interactive_videos.where(id: @interactive_video.id)
  end

  def check_for_post_survey
    # Check if there's a survey planed after the interactive video
    post_survey = Survey.all.joins(
        'join online_program_interactive_videos on surveys.id = online_program_interactive_videos.post_survey_id').
        where('online_program_interactive_videos.id = ?', @interactive_video.id).first

    if post_survey != nil
      player_answer =  PlayerAnswer.where("player_group_id = ? AND player_id = ? AND survey_id = ?",
                                          current_player_group.id, current_player.id, post_survey.id).first

      if player_answer == nil
        # user didn't take this survey
        redirect_to polymorphic_path(post_survey) + "?post_survey=" +
                        post_interactive_interactive_video_path(params[:id])
      end
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  #def interactive_video_params
  #  params.require(:interactive_video).permit(:name, :content, :language_code_id, :description)
  #end
end
