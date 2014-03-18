class PlayerAnswersController < BaseController
  before_action :set_player_answer, only: [:show, :edit, :update, :destroy]

  # GET /player_answers
  # GET /player_answers.json
  def index
    authorize! :read, PlayerAnswer
    @player_answers = PlayerAnswer.all
  end

  # GET /player_answers/1
  # GET /player_answers/1.json
  def show
    authorize! :read, PlayerAnswer
  end

  # GET /player_answers/new
  def new
    authorize! :create, PlayerAnswer
    @player_answer = PlayerAnswer.new
  end

  # GET /player_answers/1/edit
  def edit
    authorize! :update, PlayerAnswer
  end

  # POST /player_answers
  # POST /player_answers.json
  def create
    authorize! :create, PlayerAnswer
    @player_answer = PlayerAnswer.new(player_answer_params)
    p ">>>>>>>>"
    p player_answer_params
    p ">>>>>>>>"

    respond_to do |format|
      if @player_answer.save
        format.html { redirect_to @player_answer, notice: 'Player answer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @player_answer }
      else
        format.html { render action: 'new' }
        format.json { render json: @player_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /player_answers/1
  # PATCH/PUT /player_answers/1.json
  def update
    authorize! :update, PlayerAnswer
    respond_to do |format|
      if @player_answer.update(player_answer_params)
        format.html { redirect_to @player_answer, notice: 'Player answer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @player_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /player_answers/1
  # DELETE /player_answers/1.json
  def destroy
    authorize! :update, PlayerAnswer
    @player_answer.destroy
    respond_to do |format|
      format.html { redirect_to player_answers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player_answer
      @player_answer = PlayerAnswer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_answer_params
      puts ">>>"
      puts params
      puts ">>>"
      params.require(:player_answer).permit(:player_group_id, :survey_id, :question_id, :answer_number, :player_answer)
    end
end
