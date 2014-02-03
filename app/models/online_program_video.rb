class OnlineProgramVideo < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :online_program, :presence => true
	validates :video_id, :presence => true

	# == ASSOCIATIONS ==
	belongs_to :online_program
	belongs_to :video
	belongs_to :pre_survey, foreign_key: :pre_survey_id, class_name: Survey
	belongs_to :post_survey, foreign_key: :post_survey_id, class_name: Survey

end
