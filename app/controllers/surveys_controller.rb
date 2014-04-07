class SurveysController < BaseController
  before_action :set_survey

  def show
    authorize! :read, Survey
    @survey_questions = @survey.questions_surveys.includes(:question)
  end

  def post_answers
    # TODO: check if the player already took this survey
    # TODO: validate the player answered all questions
    authorize! :create, PlayerAnswer
    current_player_group
    current_player
    player_answers = []
    player_answer_params.each do |q, a|
      # Get Question
      question  = @survey.questions_surveys[q.to_i].question

      player_answers << {player_group_id: current_player_group.id,
                         player_id: current_player.id,
                         survey_id: @survey.id,
                         question_id: question.id,
                         answer_number: a.to_i}
    end


    current_player.add_points(1000)
    flash[:points] = ["You answered a questionnaire!<br>you get extra" , '1000']

    respond_to do |format|
      if PlayerAnswer.create(player_answers)
        format.html { redirect_to params['post_survey'] }
        format.js   { redirect_to params['post_survey'] }
      else
        format.html { redirect_to "/", alert: "Couldn't save user answers." }
        format.js   { redirect_to "/", alert: "Couldn't save user answers." }
      end
    end
  end

  def set_survey
    @survey = Survey.find(params[:id])
  end

  def player_answer_params
    params.require(:player_answers).permit("0", "1", "2", "3", :player_answer)
  end
end
