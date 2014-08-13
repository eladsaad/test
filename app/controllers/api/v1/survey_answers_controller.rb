class Api::V1::SurveyAnswersController < Api::BaseApiController

	def create
		@external_survey_id = params.require(:survey_id)
		@survey = Survey.find_by_external_id(@external_survey_id)
		authorize! :answer, @survey

		answers = params.require(:answers)
		answers = answers.values if answers.is_a?(Hash)

		success, errors = PlayerAnswer.save_answers(@external_survey_id, current_player, answers)
		
		if !success && errors.any?
			render_error(:unprocessable_entity, errors)
		end
	end

end