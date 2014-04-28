class Api::V1::SurveyAnswersController < Api::BaseApiController

	before_filter :verify_not_already_answered

	def create
		@survey = Survey.find(params.require(:survey_id))
		authorize! :answer, @survey
		answers = params.require(:answers)
		answers = answers.values if answers.is_a?(Hash)

		survey_question_ids = @survey.questions.pluck(:id)

		errors = []
		answers_to_create = []
		answered_question_ids = []

		answers.each_with_index do |answer, index|

			new_answer = PlayerAnswer.new(
				player_group_id: current_player.current_player_group.id,
				player_id: current_player.id,
				survey_id: @survey.id,
				question_id: answer['question_id'],
				answer_number: answer['answer_number']
			)

			new_answer.valid?

			errors << {question_id: new_answer.question_id, errors: new_answer.errors.full_messages} if new_answer.errors.any?
			answered_question_ids << new_answer.question_id

			answers_to_create << new_answer
            
		end

		(survey_question_ids - answered_question_ids).each do |missing_question_id|
			errors << { question_id: missing_question_id, errors: ['Question is missing']}
		end
		
		if errors.any?
			render_error(:unprocessable_entity, errors )
		else
			PlayerAnswer.transaction do
			  answers_to_create.each(&:save)
			end
			current_player.add_points(1000, :survey_answer)
		end
	end


	protected

		def verify_not_already_answered
			if PlayerAnswer.find_by_player_and_survey_id(current_player, params.require(:survey_id)).any?
				render_error(:survey_already_answered)
			end
		end

end