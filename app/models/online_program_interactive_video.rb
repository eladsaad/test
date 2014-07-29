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

	default_scope { order(:start_after_days, :start_time) }

	# == PLAYER PROGRESS ==

	def enabled_for_group?(player_group)
		Time.now.to_i >= self.enabled_time(player_group)
	end

	def enabled_for_player?(player)
		group_enabled = self.enabled_for_group?(player.current_player_group)
		return false unless group_enabled
		last_watched_index = player.current_progress.last_interactive_video_index
		return self.index_in_program <= last_watched_index+1 
	end

	def watched?(player)
		last_watched_index = player.current_progress.last_interactive_video_index
		return self.index_in_program <= last_watched_index
	end

	def enabled_time(player_group)
		enabled_date = player_group.screening_date + self.start_after_days.days
		enabled_time = enabled_date.to_time.to_i + self.start_time.hour.hours + self.start_time.min.minutes + self.start_time.sec.seconds
	end

	def index_in_program
		self.online_program.online_program_interactive_videos.pluck(:interactive_video_id).index(self.interactive_video_id)+1
	end

	def watched_by!(player)

		# update player's progress
	    progress = player.current_progress
	    current_video_index = self.index_in_program
	    if (progress.last_interactive_video_index < current_video_index)
	      progress.last_interactive_video_index = current_video_index
	      progress.save!
	    end

	    # check how far from the opening time the user watched the video
	    hours_diff = (Time.now.to_i - self.enabled_time(player.current_player_group)).hours
	    if (hours_diff > 24 ) # TODO: make hours diff threshold configurable
	    	player.add_points(:interactive_video_watch, {interactive_video_id: self.interactive_video_id})
    	else
    		player.add_points(:interactive_video_watch_early, {interactive_video_id: self.interactive_video_id})
	    end
	end

end

