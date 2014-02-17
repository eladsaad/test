class InteractiveVideosController < BaseController
  before_action :set_interactive_video, only: [:show, :content]

  def index
    authorize! :index, InteractiveVideo
    @interactive_videos = InteractiveVideo.all
  end

  def show
    render :layout => false
    authorize! :read, @interactive_video
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
