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

	def watched_by!(player)

		# update player's progress
	    progress = player.current_progress
	    current_video_index = self.index_in_program
	    if (progress.last_interactive_video_index < current_video_index)
	      progress.last_interactive_video_index = current_video_index
	      progress.save!
	    end

	    # check how far from the opening time the user watched the video
	    seconds_diff = (Time.now - OnlineProgramInteractiveVideo.interactive_available_time(
	    	self.online_program.id,
	        self.interactive_video_id,
	        player.current_player_group.screening_date)).to_i

	    hours_diff = seconds_diff / 3600
	    if (hours_diff > 24 ) # TODO: make hours diff threshold configurable
	    	points_to_add = 1000
    	else
    		points_to_add = 3000
	    end

	    player.add_points(points_to_add, :interactive_video_watch)
	end


  def self.interactive_available_time(online_program_id, interactive_video_id, screening_date)
    video_program_data = self.where('online_program_id = ? and interactive_video_id = ?',
                                                             online_program_id,
                                                             interactive_video_id).first

    #puts '>>>>>' + current_player_group.screening_date.strftime('%a %b %d %H:%M:%S %Z %Y')
    start_time = video_program_data.start_time
    start_after_days =  video_program_data.start_after_days
    opening_time = (screening_date + start_after_days.days) + start_time.hour.hours +
        start_time.min.minutes + start_time.sec.seconds
  end

end
