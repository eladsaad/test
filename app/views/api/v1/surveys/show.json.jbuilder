json.id @external_survey_id
json.extract! @survey, :name
json.questions @survey.questions_surveys do |survey_question|
	json.id survey_question.question_id
	json.number survey_question.question_number
	json.extract! survey_question.question, :name, :question
	json.answers (1..survey_question.question.answers.length) do |index|
		json.number index
		json.answer survey_question.question.answers[index-1]
	end
end