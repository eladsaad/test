class Api::V1::SurveyAnswersController < Api::BaseApiController

	def create
		@survey = Survey.find(params[:survey_id])
		authorize! :answer, @survey
		answers = params.require(:answers)
		new_answers = []
		answers.each do |answer|
			new_answers << {
				player_group_id: current_player.current_player_group.id,
				player_id: current_player.id,
				survey_id: @survey.id,
				question_id: answer.question_id,
				answer_number: answer.answer_number
            }
		end
		if PlayerAnswer.create(player_answers)
			render :json=> {:success=>true}
		else
			render :json=> {:success=>false, :message=>"Cannot save answers"}, :status=>401
		end
	end


end