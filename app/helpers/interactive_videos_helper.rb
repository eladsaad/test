module InteractiveVideosHelper

	def episode_class(index)
		next_to_watch = [@last_watched_index+1, @last_enabled_index].min
		if (index == next_to_watch + 1)
      'disabled upcoming'
    elsif (index > next_to_watch)
			'disabled'
		elsif (index == next_to_watch && @last_watched_index+1 <= @last_enabled_index)
			'enabled current'
		else
			'enabled'
		end
  end

  def upcoming?(index)
    next_to_watch = [@last_watched_index+1, @last_enabled_index].min
    index == next_to_watch + 1
  end

	def present_class
		if (@last_watched_index == @interactive_videos.length)
			'enabled'
		else
			'disabled'
		end
  end

  def upcoming_msg(episode_index)
    current_video = OnlineProgramInteractiveVideo.find(program_video_id_by_index(episode_index - 1))
    seconds_diff = (current_video.enabled_time(@current_player_group) - Time.now.to_i).seconds

    return "" unless (seconds_diff > 0)

    upcoming_message = "This video will be available in "

    days = seconds_diff / 86400
    seconds_diff -= days * 86400
    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600
    minutes = seconds_diff / 60
    seconds_diff -= minutes * 60
    seconds = seconds_diff

    if (days == 1)
      upcoming_message += "one day"
    elsif (days > 1)
      upcoming_message += "#{days} days"
    elsif (hours == 1)
      upcoming_message += "one hour"
      if (minutes > 1)
        upcoming_message += " and #{minutes} minutes"
      end
    elsif (hours > 1)
      upcoming_message += "#{hours} hours"
    elsif (minutes == 1)
      upcoming_message += "1 minute"
    elsif (minutes > 1)
      upcoming_message += "#{minutes} minutes"
    else
      upcoming_message += "a few seconds"
    end

    return upcoming_message

  end

  def interactive_video_id_by_index(index)
    @current_online_program.online_program_interactive_videos.order(:start_after_days).
        offset(index).limit(1).first.interactive_video_id
  end

  def program_video_id_by_index(index)
    @current_online_program.online_program_interactive_videos.order(:start_after_days).
        offset(index).limit(1).first.id
  end
end