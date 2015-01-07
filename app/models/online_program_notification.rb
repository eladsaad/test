# == Schema Information
#
# Table name: online_program_notifications
#
#  id                :integer          not null, primary key
#  online_program_id :integer
#  notification_id   :integer
#  start_after_days  :integer
#  start_time        :time
#  created_at        :datetime
#  updated_at        :datetime
#

class OnlineProgramNotification < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :online_program, :presence => true
	validates :notification_id, :presence => true

	# == ASSOCIATIONS ==
	belongs_to :online_program
	belongs_to :notification

end
