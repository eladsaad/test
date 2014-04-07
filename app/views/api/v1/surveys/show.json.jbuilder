json.extract! @survey, :id, :name
json.questions @survey.questions_surveys do |survey_question|
	json.extract! survey_question question_number, question.name, question.question, question.answers
end