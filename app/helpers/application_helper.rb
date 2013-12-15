module ApplicationHelper

	def flash_class(level)
		case level
			when :notice then "alert-msg-notice"
			when :success then "alert-msg-success"
			when :error then "alert-msg-error"
			when :alert then "alert-msg-alert"
			else level.to_s
		end
	end

	def is_active_class?(link_path)
		current_page?(link_path) ? 'active' : ''
 	end

end
