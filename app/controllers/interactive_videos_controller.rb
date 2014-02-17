class InteractiveVideosController < BaseController
  before_action :set_interactive_video, only: [:show, :content]

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

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_interactive_video
    @interactive_video = InteractiveVideo.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  #def interactive_video_params
  #  params.require(:interactive_video).permit(:name, :content, :language_code_id, :description)
  #end
end
