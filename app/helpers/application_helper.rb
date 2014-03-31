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


  def changeMainView (partial_name)
    js_script = raw("$('#main-content').html('") + raw(escape_javascript(render partial_name)) + raw("');")

    if flash[:alert] || flash[:notice] || flash[:message] || flash[:error] || flash[:success] ||flash[:warning] ||
        flash[:failure]
      js_script += raw("bootbox.alert('#{escape_javascript(render partial: "shared/flash_messages", flash: flash)}');")
    end

    if flash[:points]
      js_script += raw("$('.modal-inner-content').html('#{
          escape_javascript(render partial: "shared/score_modal",flash: flash)
      }');")
      js_script += raw("$('.modal-view').css({visibility: 'visible'});")
      js_script += raw("$('.user-points').html(numberWithCommas(#{ current_player.score }));")
    end

    js_script
  end

end
