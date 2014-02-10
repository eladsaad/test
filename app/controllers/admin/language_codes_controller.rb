class Admin::LanguageCodesController < Admin::AdminController
  before_action :set_admin_language_code, only: [:show, :edit, :update, :destroy]

  allowed_sort_columns Admin::LanguageCode

  set_pagination_headers :admin_language_codes, only: [:index]

  # GET /admin/language_codes
  # GET /admin/language_codes.json
  def index
    authorize! :index, LanguageCode
    @admin_language_codes = Admin::LanguageCode.accessible_by(current_ability, :read)
    @admin_language_codes = @admin_language_codes.search(params[:search]) unless params[:search].blank?
    @admin_language_codes = @admin_language_codes.order("#{sort_column} #{sort_direction}") unless sort_column.blank?
    @admin_language_codes = @admin_language_codes.paginate(page: params[:page], per_page: 5)
  end

  # GET /admin/language_codes/1
  # GET /admin/language_codes/1.json
  def show
    authorize! :read, @admin_language_code
  end

  # GET /admin/language_codes/new
  def new
    authorize! :new, LanguageCode
    @admin_language_code = Admin::LanguageCode.new
  end

  # GET /admin/language_codes/1/edit
  def edit
    authorize! :edit, @admin_language_code
  end

  # POST /admin/language_codes
  # POST /admin/language_codes.json
  def create
    @admin_language_code = Admin::LanguageCode.new(admin_language_code_params)
    authorize! :create, @admin_language_code

    respond_to do |format|
      if @admin_language_code.save
        format.html { redirect_to @admin_language_code, notice: 'Language code was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin_language_code }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_language_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/language_codes/1
  # PATCH/PUT /admin/language_codes/1.json
  def update
    authorize! :update, @admin_language_code

    respond_to do |format|
      if @admin_language_code.update(admin_language_code_params)
        format.html { redirect_to @admin_language_code, notice: 'Language code was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_language_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/language_codes/1
  # DELETE /admin/language_codes/1.json
  def destroy
    authorize! :destroy, @admin_language_code

    @admin_language_code.destroy
    respond_to do |format|
      format.html { redirect_to admin_language_codes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_language_code
      @admin_language_code = Admin::LanguageCode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_language_code_params
      params.require(:admin_language_code).permit(:name, :code)
    end
end
