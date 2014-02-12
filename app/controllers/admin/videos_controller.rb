class Admin::VideosController < Admin::AdminController
  before_action :set_admin_video, only: [:show, :edit, :update, :destroy]

  allowed_sort_columns Admin::Video

  set_pagination_headers :admin_videos, only: [:index]

  # GET /admin/videos
  # GET /admin/videos.json
  def index
    authorize! :index, Video
    @admin_videos = Admin::Video.accessible_by(current_ability, :read)
    @admin_videos = @admin_videos.search(params[:search]) unless params[:search].blank?
    @admin_videos = @admin_videos.order("#{sort_column} #{sort_direction}") unless sort_column.blank?
    @admin_videos = @admin_videos.paginate(page: params[:page], per_page: params[:per_page] || 100)
  end

  # GET /admin/videos/1
  # GET /admin/videos/1.json
  def show
    authorize! :read, @admin_video
  end

  # GET /admin/videos/new
  def new
    @admin_video = Admin::Video.new
    authorize! :new, @admin_video

    @language_codes = Admin::LanguageCode.all
  end

  # GET /admin/videos/1/edit
  def edit
    authorize! :edit, @admin_video

    @language_codes = Admin::LanguageCode.all
  end

  # POST /admin/videos
  # POST /admin/videos.json
  def create
    @admin_video = Admin::Video.new(admin_video_params)
    authorize! :create, @admin_video

    respond_to do |format|
      if @admin_video.save
        format.html { redirect_to @admin_video, notice: 'Video was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin_video }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/videos/1
  # PATCH/PUT /admin/videos/1.json
  def update
    authorize! :update, @admin_video

    respond_to do |format|
      if @admin_video.update(admin_video_params)
        format.html { redirect_to @admin_video, notice: 'Video was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/videos/1
  # DELETE /admin/videos/1.json
  def destroy
    authorize! :destroy, @admin_video
    @admin_video.destroy
    respond_to do |format|
      format.html { redirect_to admin_videos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_video
      @admin_video = Admin::Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_video_params
      params.require(:admin_video).permit(:url, :thumbnail_url, :name, :language_code_id, :description)
    end
end
