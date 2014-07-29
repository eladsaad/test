class Admin::InteractiveVideosController < Admin::AdminController
  before_action :set_admin_interactive_video, only: [:show, :edit, :update, :destroy, :content]

  allowed_sort_columns Admin::InteractiveVideo

  set_pagination_headers :admin_interactive_videos, only: [:index]

  # GET /admin/interactive_videos
  # GET /admin/interactive_videos.json
  def index
    authorize! :index, InteractiveVideo
    @admin_interactive_videos = Admin::InteractiveVideo.accessible_by(current_ability, :read)
    @admin_interactive_videos = @admin_interactive_videos.search(params[:search]) unless params[:search].blank?
    @admin_interactive_videos = @admin_interactive_videos.order("#{sort_column} #{sort_direction}") unless sort_column.blank?
    @admin_interactive_videos = @admin_interactive_videos.paginate(page: params[:page], per_page: params[:per_page] || 100)
  end

  # GET /admin/interactive_videos/1
  # GET /admin/interactive_videos/1.json
  def show
    authorize! :read, @admin_interactive_video
  end

  # GET /admin/interactive_videos/new
  def new
    @admin_interactive_video = Admin::InteractiveVideo.new
    authorize! :new, @admin_interactive_video

    @language_codes = Admin::LanguageCode.all
  end

  # GET /admin/interactive_videos/1/edit
  def edit
    authorize! :edit, @admin_interactive_video

    @language_codes = Admin::LanguageCode.all
  end

  # POST /admin/interactive_videos
  # POST /admin/interactive_videos.json
  def create
    @admin_interactive_video = Admin::InteractiveVideo.new(admin_interactive_video_params)
    authorize! :create, @admin_interactive_video

    respond_to do |format|
      if @admin_interactive_video.save
        format.html { redirect_to @admin_interactive_video, notice: 'Interactive video was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin_interactive_video }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_interactive_video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/interactive_videos/1
  # PATCH/PUT /admin/interactive_videos/1.json
  def update
    authorize! :update, @admin_interactive_video
    respond_to do |format|
      if @admin_interactive_video.update(admin_interactive_video_params)
        format.html { redirect_to @admin_interactive_video, notice: 'Interactive video was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_interactive_video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/interactive_videos/1
  # DELETE /admin/interactive_videos/1.json
  def destroy
    authorize! :destroy, @admin_interactive_video
    @admin_interactive_video.destroy
    respond_to do |format|
      format.html { redirect_to admin_interactive_videos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_interactive_video
      @admin_interactive_video = Admin::InteractiveVideo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_interactive_video_params
      params.require(:admin_interactive_video).permit(:name, :content, :content_mobile, :language_code_id, :description, :thumbnail_url, :thumbnail_disabled_url)
    end
end
