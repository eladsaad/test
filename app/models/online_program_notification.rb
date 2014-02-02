class OnlineProgramNotification < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :online_program_id, :presence => true
	validates :notification_id, :presence => true

	# == ASSOCIATIONS ==
	belongs_to :online_program
	belongs_to :notification

end
