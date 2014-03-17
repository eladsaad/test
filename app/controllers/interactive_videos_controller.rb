class InteractiveVideosController < BaseController
  before_action :set_interactive_video, only: [:show, :content, :post_interactive]
  before_action :check_for_pre_survey, only: [:show]

  def index
    authorize! :index, InteractiveVideo
    @interactive_videos = current_player.current_online_program.online_program_interactive_videos.order(:start_after_days)
    @last_watched_index = current_player.current_progress.last_interactive_video_index
    @last_enabled_index = current_player.current_online_program.enabled_interactive_videos(current_player.current_player_group).size
  end

  def show
    render :layout => false
    authorize! :read, @interactive_video

    # update player's progress
    progress = current_player.current_progress
    current_video_index = @interactive_video.index_in_program(current_player.current_online_program)
    if (progress.last_interactive_video_index < current_video_index)
      progress.last_interactive_video_index = current_video_index
      progress.save!
    end
  end

  def content
    authorize! :read, @interactive_video
    render :text => @interactive_video.content, :content_type => Mime::XML
  end

  def post_interactive
    authorize! :read, @interactive_video
    # TODO: Check if there's a survey planed after the interactive video

    flash[:points] = ["You just watched an episode<br>and won extra" , '1500']
    # TODO: special rules for getting points

    redirect_to interactive_videos_path
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

  # Never trust parameters from the scary internet, only allow the white list through.
  #def interactive_video_params
  #  params.require(:interactive_video).permit(:name, :content, :language_code_id, :description)
  #end
end
