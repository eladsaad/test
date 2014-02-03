class OnlineProgramNotification < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :online_program, :presence => true
	validates :notification_id, :presence => true

	# == ASSOCIATIONS ==
	belongs_to :online_program
	belongs_to :notification

end
