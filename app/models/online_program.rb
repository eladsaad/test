class OnlineProgram < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :name, :presence => true
	validates :codename, :presence => true, :uniqueness => true

	# == ASSOCIATIONS ==
	has_many :online_program_videos
	has_many :videos, through: :online_program_videos,
		select: 'videos.*, online_program_videos.relative_time, online_program_videos.pre_survey_id, online_program_videos.post_survey_id'

	has_many :online_program_notifications
	has_many :notifications, through: :online_program_notifications,
		select: 'notifications.*, online_program_notifications.relative_time'

	# == SEARCH ==
	search_columns [:name, :codename]
	
end
