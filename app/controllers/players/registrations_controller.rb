class Players::RegistrationsController < Devise::RegistrationsController
	
	before_filter :configure_permitted_parameters

	def pre_sign_up

		group = PlayerGroup.find_by_reg_code(params[:reg_code])

		if group.nil? || !group.active?
			redirect_to :back, alert: t(:invalid_registration_code)
		else
			if params[:facebook]
				redirect_to omniauth_authorize_path(:player, :facebook, reg_code: params[:reg_code])
			else
				redirect_to new_player_registration_path(reg_code: params[:reg_code])
			end
		end
	end


  	protected

	  	def configure_permitted_parameters
		    devise_parameter_sanitizer.for(:sign_up) << [:username, :email, :first_name, :last_name, :birth_date, :gender, :age]
		    devise_parameter_sanitizer.for(:account_update) << [:username, :email, :first_name, :last_name, :birth_date, :gender, :age]
	  	end

end