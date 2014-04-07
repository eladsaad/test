class AddMissingQuestionNumbers < ActiveRecord::Migration
  def change
  	Survey.all.each do |survey|
  		survey.questions_surveys.order(:created_at).each_with_index do |question_survey, index|
  			question_survey.question_number = index+1
  			question_survey.save!
		end
  	end
  end
end
