class QuestionsSurvey < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :survey_id, :presence => true
	validates :question_id, :presence => true
	validates :question_number, :presence => true

	# == ASSOCIATIONS ==
	belongs_to :survey
	belongs_to :question

	# == SETTINGS ==

	default_scope { order('question_number ASC') } 

end
