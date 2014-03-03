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

 	def sortable_column(column, title)
 		column = column.to_s
 		css_class = (column == sort_column) ? "column-sort-#{sort_direction}" : nil
	    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc" 
	    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {class: css_class}
  end

  #def link_to_submit(*args, &block)
  #  link_to_function (block_given? ? capture(&block) : args[0]), "$(this).closest('form').submit()", args.extract_options!
  #end

end
