module Api::V1::InteractiveVideosHelper


	def enabled_time_message(enabled_time)

		seconds_diff = (enabled_time - Time.now.to_i).seconds

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

end