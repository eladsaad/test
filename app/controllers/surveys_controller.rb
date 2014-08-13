class SurveysController < BaseController
  before_action :set_survey

  def show
    authorize! :read, @survey
    @survey_questions = @survey.questions_surveys.includes(:question)
  end

  def post_answers

    authorize! :answer, @survey

    answers = []
    player_answer_params.each do |q, a|
      answers << {
        'question_id' => q,
        'answer_number' => a
      }
    end

    success, errors = PlayerAnswer.save_answers(@external_survey_id, current_player, answers)

    respond_to do |format|
      if success
        format.html { redirect_to params['post_survey'] }
        format.js   { redirect_to params['post_survey'] }
      else
        Rails.logger.debug "Error saving survey answers: #{errors}"
        format.html { redirect_to "/", alert: "Couldn't save user answers." }
        format.js   { redirect_to "/", alert: "Couldn't save user answers." }
      end
    end
  end



  def set_survey
    @external_survey_id = params[:id]
    @survey = Survey.find_by_external_id(@external_survey_id)
  end

  def player_answer_params
    params.require(:player_answers) # permit array
  end
end
