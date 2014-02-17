module InteractiveVideosHelper

	def episode_class(index)
		next_to_watch = [@last_watched_index+1, @last_enabled_index].min
		if (index > next_to_watch)
			'disabled'
		elsif (index == next_to_watch && @last_watched_index+1 <= @last_enabled_index)
			'enabled current'
		else
			'enabled'
		end
	end

	def present_class
		if (@last_watched_index == @interactive_videos.length)
			'enabled'
		else
			'disabled'
		end
	end
end