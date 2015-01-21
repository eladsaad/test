# == Schema Information
#
# Table name: online_program_interactive_videos
#
#  id                   :integer          not null, primary key
#  online_program_id    :integer
#  interactive_video_id :integer
#  start_after_days     :integer
#  start_time           :time
#  pre_survey_id        :integer
#  post_survey_id       :integer
#  created_at           :datetime
#  updated_at           :datetime
#

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


	# == EXTERNAL SURVEY IDS ==
	# See "Survey" model for details

	def external_pre_survey_id
		return nil if self.pre_survey_id.blank?
		Survey.encode_external_id(self.pre_survey_id, self.id, 'pre')
	end

	def external_post_survey_id
		return nil if self.post_survey_id.blank?
		Survey.encode_external_id(self.post_survey_id, self.id, 'post')
	end

	# == PLAYER PROGRESS ==

	def enabled_for_group?(player_group)
		Time.now.to_i >= self.enabled_time(player_group)
	end

	def enabled_for_player?(player)
		group_enabled = self.enabled_for_group?(player.player_group)
		return false unless group_enabled
		last_watched_index = player.player_progress.last_interactive_video_index
		return self.index_in_program <= last_watched_index+1 
	end

	def watched?(player)
		last_watched_index = player.player_progress.last_interactive_video_index
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

		first_watch = false

		# update player's progress
	    progress = player.player_progress
	    current_video_index = self.index_in_program
	    if (progress.last_interactive_video_index < current_video_index)
	      first_watch = true
	      progress.last_interactive_video_index = current_video_index
	      progress.save!
	    end

	    # add points
	    if first_watch

		    # check how far from the opening time the user watched the video
		    hours_diff = (Time.now.to_i - self.enabled_time(player.player_group)) / 1.hour
		    if (hours_diff > 24 ) # TODO: make hours diff threshold configurable

          # Increase the player points by the amount specified for the specific video number event
          case current_video_index
            when 1
              player.add_points(:extra_for_first_movie, {interactive_video_id: self.interactive_video_id})
            when 2
              player.add_points(:extra_for_second_movie, {interactive_video_id: self.interactive_video_id})
            when 3
              player.add_points(:extra_for_third_movie, {interactive_video_id: self.interactive_video_id})
            when 4
              player.add_points(:extra_for_fourth_movie, {interactive_video_id: self.interactive_video_id})
            when 5
              player.add_points(:extra_for_fifth_movie, {interactive_video_id: self.interactive_video_id})
            when 6
              player.add_points(:extra_for_sixth_movie, {interactive_video_id: self.interactive_video_id})
          end

        else

          # Increase the player points by the amount specified for the specific video number event
          case current_video_index
            when 1
              player.add_points(:extra_for_first_movie_early, {interactive_video_id: self.interactive_video_id})
            when 2
              player.add_points(:extra_for_second_movie_early, {interactive_video_id: self.interactive_video_id})
            when 3
              player.add_points(:extra_for_third_movie_early, {interactive_video_id: self.interactive_video_id})
            when 4
              player.add_points(:extra_for_fourth_movie_early, {interactive_video_id: self.interactive_video_id})
            when 5
              player.add_points(:extra_for_fifth_movie_early, {interactive_video_id: self.interactive_video_id})
            when 6
              player.add_points(:extra_for_sixth_movie_early, {interactive_video_id: self.interactive_video_id})
          end

		    end
			else
        #  Limit reply points to 9 times.
	    	player.add_points(:interactive_video_watch_again, {interactive_video_id: self.interactive_video_id}) unless player.player_score_updates.where(event:"interactive_video_watch_again").size > 9
      end


	end

end

