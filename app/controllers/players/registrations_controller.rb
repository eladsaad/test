class Players::RegistrationsController < Devise::RegistrationsController
	
	before_filter :configure_permitted_parameters

  	protected

	  	def configure_permitted_parameters
		    devise_parameter_sanitizer.for(:sign_up) << [:username, :email, :first_name, :last_name, :birth_date]
		    devise_parameter_sanitizer.for(:account_update) << [:username, :email, :first_name, :last_name, :birth_date]
	  	end
end