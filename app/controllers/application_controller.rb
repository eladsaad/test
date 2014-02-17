class ApplicationController < ActionController::Base

  layout :set_layout

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # == CANCAN Authorization ==
  check_authorization :unless => :check_authorization_controllers

  def check_authorization_controllers
    devise_controller? || is_a?(StaticPagesController)
  end 

  rescue_from CanCan::AccessDenied do |exception|
  	Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
  	if request.env["HTTP_REFERER"].present?
  		redirect_to :back, :alert => exception.message
  	else
  		redirect_to root_url, :alert => exception.message
  	end
  end

  # == Sorting
  
  def self.allowed_sort_columns(model_class)
    define_method :sort_column do
      model_class.column_names.include?(params[:sort]) ? params[:sort] : nil
    end
    define_method :sort_direction do
      ['asc', 'desc'].include?(params[:direction]) ?  params[:direction] : "asc"
    end
    helper_method :sort_column, :sort_direction
  end


  # == Current Online Program

  def current_online_program
    program = nil
    if (current_player)
      program ||= current_player.try(:current_player_group).try(:current_online_program)
    else
      program ||= OnlineProgram.find_by_codename(OnlineProgram::DEFAULT_PROGRAM_CODE_NAME)
    end
    program
  end

  # == Pagination Headers

  protected
  
  def self.set_pagination_headers(name, options = {})
    after_filter(options) do |controller|
      results = instance_variable_get("@#{name}")
      headers["X-Pagination"] = {
        total: results.total_entries,
        total_pages: results.total_pages,
        first_page: results.current_page == 1,
        last_page: results.next_page.blank?,
        previous_page: results.previous_page,
        next_page: results.next_page,
        out_of_bounds: results.out_of_bounds?,
        offset: results.offset
      }.to_json
    end
  end

  def set_layout
    false if params[:no_layout]
  end
  

end
