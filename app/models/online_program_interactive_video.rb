class OnlineProgramInteractiveVideo < ActiveRecord::Base

	# == VALIDATIONS ==
	validates :online_program, :presence => true
	validates :interactive_video_id, :presence => true

	# == ASSOCIATIONS ==
	belongs_to :online_program
	belongs_to :interactive_video
	belongs_to :pre_survey, foreign_key: :pre_survey_id, class_name: Survey
	belongs_to :post_survey, foreign_key: :post_survey_id, class_name: Survey

	# == ORDER ==

	default_scope { order(:start_after_days) } 

	# == PLAYER PROGRESS ==

	def enabled_for_group?(player_group)
		days_since_start = (Date.today - player_group.screening_date).to_i
		current_time = Time.now.strftime("%H:%M:%S")
		result = (self.start_after_days < days_since_start) || (self.start_after_days == days_since_start && self.start_time <= current_time)
	end

	def watched?(player)
		last_watched_index = player.current_progress.last_interactive_video_index
		return self.index_in_program <= last_watched_index
	end

	def index_in_program
		self.online_program.online_program_interactive_videos.pluck(:interactive_video_id).index(self.interactive_video_id)+1
	end

end
