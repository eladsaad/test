class Api::V1::SurveyAnswersController < Api::BaseApiController

	def create
		@survey = Survey.find(params[:survey_id])
		authorize! :answer, @survey
		answers = params.require(:answers)
		player_answers_to_create = []
		answers.each do |index, answer|
			player_answers_to_create << {
				player_group_id: current_player.current_player_group.id,
				player_id: current_player.id,
				survey_id: @survey.id,
				question_id: answer['question_id'],
				answer_number: answer['answer_number']
            }
		end
		if PlayerAnswer.create(player_answers_to_create)
			render :json=> {:success=>true}
		else
			render :json=> {:success=>false, :message=>"Cannot save answers"}, :status=>401
		end
	end


end