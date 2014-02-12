class Admin::SurveysController < Admin::AdminController
  before_action :set_admin_survey, only: [:show, :edit, :update, :destroy,
                                          :edit_questions, :add_question, :remove_question]

  allowed_sort_columns Admin::Survey

  set_pagination_headers :admin_surveys, only: [:index]

  # GET /admin/surveys
  # GET /admin/surveys.json
  def index
    authorize! :index, Survey
    @admin_surveys = Admin::Survey.accessible_by(current_ability, :read)
    @admin_surveys = @admin_surveys.search(params[:search]) unless params[:search].blank?
    @admin_surveys = @admin_surveys.order("#{sort_column} #{sort_direction}") unless sort_column.blank?
    @admin_surveys = @admin_surveys.paginate(page: params[:page], per_page: params[:per_page] || 100)
  end

  # GET /admin/surveys/1
  # GET /admin/surveys/1.json
  def show
    authorize! :read, @admin_survey
  end

  # GET /admin/surveys/new
  def new
    @admin_survey = Admin::Survey.new
    authorize! :new, @admin_survey

    @language_codes = Admin::LanguageCode.all
  end

  # GET /admin/surveys/1/edit
  def edit
    authorize! :edit, @admin_survey

    @language_codes = Admin::LanguageCode.all
  end

  # POST /admin/surveys
  # POST /admin/surveys.json
  def create
    @admin_survey = Admin::Survey.new(admin_survey_params)
    authorize! :create, @admin_survey

    respond_to do |format|
      if @admin_survey.save
        format.html { redirect_to @admin_survey, notice: 'Survey was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin_survey }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/surveys/1
  # PATCH/PUT /admin/surveys/1.json
  def update
    authorize! :update, @admin_survey

    respond_to do |format|
      if @admin_survey.update(admin_survey_params)
        format.html { redirect_to @admin_survey, notice: 'Survey was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/surveys/1
  # DELETE /admin/surveys/1.json
  def destroy
    authorize! :destroy, @admin_survey
    @admin_survey.destroy
    respond_to do |format|
      format.html { redirect_to admin_surveys_url }
      format.json { head :no_content }
    end
  end

  def add_question
    authorize! :update, @admin_survey

    @question = Admin::Question.find(params[:question_id])
    if @question.nil?
      redirect_to :back, error: 'Something went wrong.'
    else
      @admin_survey.questions << @question
      redirect_to :back, notice: 'Survey was successfully updated.'
    end
  end

  def remove_question
    authorize! :update, @admin_survey

    @question = @admin_survey.questions.where(id: params[:question_id])
    if @question.nil?
      redirect_to :back, error: 'Something went wrong.'
    else
      @admin_survey.questions.delete(@question)
      redirect_to :back, notice: 'Survey was successfully updated.'
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_survey
      @admin_survey = Admin::Survey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_survey_params
      params.require(:admin_survey).permit(:name, :language_code_id, :question_ids)
    end

    def admin_question_params
      params.require(:admin_question).permit(:name, :language_code_id, :question, :answers, :correct_answer)
    end
end
