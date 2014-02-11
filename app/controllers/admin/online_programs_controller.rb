class Admin::OnlineProgramsController < Admin::AdminController
  before_action :set_admin_online_program, only: [:show, :edit, :update, :destroy]

  allowed_sort_columns Admin::OnlineProgram 

  set_pagination_headers :admin_online_programs, only: [:index]

  # GET /admin/online_programs
  # GET /admin/online_programs.json
  def index
    authorize! :index, OnlineProgram
    @admin_online_programs = Admin::OnlineProgram.accessible_by(current_ability, :read)
    @admin_online_programs = @admin_online_programs.search(params[:search]) unless params[:search].blank?
    @admin_online_programs = @admin_online_programs.order("#{sort_column} #{sort_direction}") unless sort_column.blank?
    @admin_online_programs = @admin_online_programs.paginate(page: params[:page], per_page: params[:per_page] || 100)
  end

  # GET /admin/online_programs/1
  # GET /admin/online_programs/1.json
  def show
    authorize! :read, @admin_online_program
  end

  # GET /admin/online_programs/new
  def new
    @admin_online_program = Admin::OnlineProgram.new
    @admin_online_program.online_program_videos.build
    @admin_online_program.online_program_notifications.build
    authorize! :new, @admin_online_program
  end

  # GET /admin/online_programs/1/edit
  def edit
    authorize! :edit, @admin_online_program
    @admin_online_program.online_program_videos.build unless @admin_online_program.online_program_videos.any?
    @admin_online_program.online_program_notifications.build unless @admin_online_program.online_program_notifications.any?
  end

  # POST /admin/online_programs
  # POST /admin/online_programs.json
  def create
    @admin_online_program = Admin::OnlineProgram.new(admin_online_program_params)
    authorize! :create, @admin_online_program

    respond_to do |format|
      if @admin_online_program.save
        format.html { redirect_to @admin_online_program, notice: 'Online program was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin_online_program }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_online_program.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/online_programs/1
  # PATCH/PUT /admin/online_programs/1.json
  def update
    authorize! :update, @admin_online_program

    respond_to do |format|
      if @admin_online_program.update(admin_online_program_params)
        format.html { redirect_to @admin_online_program, notice: 'Online program was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_online_program.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/online_programs/1
  # DELETE /admin/online_programs/1.json
  def destroy
    authorize! :destroy, @admin_online_program

    @admin_online_program.destroy
    respond_to do |format|
      format.html { redirect_to admin_online_programs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_online_program
      @admin_online_program = Admin::OnlineProgram.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_online_program_params
      params.require(:admin_online_program).permit(
        :name,
        :codename,
        :language_code_id,
        :description,
        :background_image_id,
        :promo_video_id,
        :online_program_videos_attributes => [
          :interactive_video_id,
          :start_after_days,
          :start_time,
          :pre_survey_id,
          :post_survey_id,
          :id,
          :_destroy
        ],
        :online_program_notifications_attributes => [
          :notification_id,
          :start_after_days,
          :start_time,
          :id,
          :_destroy
        ]
      )
    end
end
