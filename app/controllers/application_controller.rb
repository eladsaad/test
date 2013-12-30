class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # == CANCAN Authorization ==
  check_authorization :unless => :devise_controller?
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

end
