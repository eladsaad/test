class Admin::QuestionsController < Admin::AdminController
  before_action :set_admin_question, only: [:show, :edit, :update, :destroy]

  allowed_sort_columns Admin::Question

  # GET /admin/questions
  # GET /admin/questions.json
  def index
    authorize! :index, Question
    @admin_questions = Admin::Question.accessible_by(current_ability, :read)
    @admin_questions = @admin_questions.search(params[:search]) unless params[:search].blank?
    @admin_questions = @admin_questions.order("#{sort_column} #{sort_direction}") unless sort_column.blank?
    @admin_questions = @admin_questions.paginate(page: params[:page], per_page: 5)
  end

  # GET /admin/questions/1
  # GET /admin/questions/1.json
  def show
    authorize! :read, @admin_question
  end

  # GET /admin/questions/new
  def new
    @admin_question = Admin::Question.new
    authorize! :new, @admin_question

    @language_codes = Admin::LanguageCode.all
  end

  # GET /admin/questions/1/edit
  def edit
    authorize! :edit, @admin_question

    @language_codes = Admin::LanguageCode.all
  end

  # POST /admin/questions
  # POST /admin/questions.json
  def create
    @admin_question = Admin::Question.new(admin_question_params)
    authorize! :create, @admin_question

    respond_to do |format|
      if @admin_question.save
        format.html { redirect_to @admin_question, notice: 'Question was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin_question }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/questions/1
  # PATCH/PUT /admin/questions/1.json
  def update
    authorize! :update, @admin_question

    respond_to do |format|
      if @admin_question.update(admin_question_params)
        format.html { redirect_to @admin_question, notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/questions/1
  # DELETE /admin/questions/1.json
  def destroy
    authorize! :destroy, @admin_question

    @admin_question.destroy
    respond_to do |format|
      format.html { redirect_to admin_questions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_question
      @admin_question = Admin::Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_question_params
      params.require(:admin_question).permit(:name, :language_code_id, :question, :answers, :correct_answer)
    end
end
