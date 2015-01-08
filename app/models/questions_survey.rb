# == Schema Information
#
# Table name: questions_surveys
#
#  id              :integer          not null, primary key
#  question_id     :integer
#  survey_id       :integer
#  created_at      :datetime
#  updated_at      :datetime
#  question_number :integer
#

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
