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
    seconds_diff = (OnlineProgramInteractiveVideo.interactive_available_time(@current_online_program.id,
                                                                    interactive_video_id_by_index(episode_index - 1),
                                                                    @current_player_group.screening_date) - Time.now).to_i
    upcoming_message = "This video will be available in "

    puts ">>>>>>>>> @@current_player_group.id: " + @current_player_group.id.to_s
    puts ">>>>>>>>> episode_index: " + episode_index.to_s
    puts ">>>>>>>>> interactive_video_id_by_index(episode_index - 1): " + interactive_video_id_by_index(episode_index - 1).to_s
    puts ">>>>>>>>> seconds_diff: " + seconds_diff.to_s

    if (seconds_diff > 0)
      days = seconds_diff / 86400
      seconds_diff -= days * 86400

      hours = seconds_diff / 3600
      seconds_diff -= hours * 3600

      minutes = seconds_diff / 60
      seconds_diff -= minutes * 60

      seconds = seconds_diff


      puts ">>>>>>>>> days: " + days.to_s
      puts ">>>>>>>>> hours: " + hours.to_s
      puts ">>>>>>>>> minutes: " + minutes.to_s
      puts ">>>>>>>>> episode_index: " + episode_index.to_s

      puts ">>>>>>>>> current_player_group.screening_date: " + @current_player_group.screening_date.strftime("%m/%d/%Y")

      puts ">>>>>>>>> complex: " + OnlineProgramInteractiveVideo.interactive_available_time(@current_online_program.id,
                                                                                            interactive_video_id_by_index(episode_index - 1),
                                                                                            @current_player_group.screening_date).strftime("%m/%d/%Y")

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
    else
      upcoming_message = ""
    end
  end

  def interactive_video_id_by_index(index)
    @current_online_program.online_program_interactive_videos.order(:start_after_days).
        offset(index).limit(1).first.interactive_video_id
  end
end