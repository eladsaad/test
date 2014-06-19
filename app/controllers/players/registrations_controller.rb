class Players::RegistrationsController < Devise::RegistrationsController
	
	before_filter :configure_permitted_parameters
	before_filter :verify_reg_code, only: [:pre_sign_up]
	before_filter :allow_edit_only_if_not_complete, only: [:edit, :update]

	respond_to :html, :js, :json

	def update
		self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
		prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

		account_update_params = devise_parameter_sanitizer.sanitize(:account_update)
		if account_update_params[:password].blank?
			account_update_params.delete("password")
			account_update_params.delete("password_confirmation")
			account_update_params.delete("email")
		end

		@resource_updated = self.resource.update_attributes(account_update_params)

		yield resource if block_given?

		if @resource_updated
			if is_flashing_format?
				flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
				:update_needs_confirmation : :updated
				set_flash_message :notice, flash_key
			end
			sign_in resource_name, resource, bypass: true
			respond_with resource, location: after_update_path_for(resource)
		else
			clean_up_passwords resource
			respond_with resource
		end
	end

	def pre_sign_up
		respond_to do |format|
			if params[:facebook]
				format.html { redirect_to omniauth_authorize_path(:player, :facebook, reg_code: params[:reg_code]) }
				format.js { render action: 'facebook_redirect' }
			else
				format.html { redirect_to new_player_registration_path(reg_code: params[:reg_code]) }
				format.js { redirect_to new_player_registration_path(reg_code: params[:reg_code]) }
			end
		end
	end

	def check_reg_code
		group = PlayerGroup.find_by_reg_code(params[:reg_code])

		respond_to do |format|
			if group.nil? || !group.active?
				format.json { render :json => "{ \"valid\": false }" }
			else
				format.json { render :json => "{ \"valid\": true }" }
			end
		end
	end

	protected

		def configure_permitted_parameters
			devise_parameter_sanitizer.for(:account_update) << [
				:reg_code,
				:tos_accepted,
			]

			devise_parameter_sanitizer.for(:sign_up) << [
				:username,
				:email,
				:first_name,
				:last_name,
				:birth_date,
				:gender,
				:age,
				:reg_code,
				:tos_accepted,
			]

		end

		def after_inactive_sign_up_path_for(resource)
			"/confirm_reg"
		end

		def verify_reg_code
			redirect_to :back, alert: t(:invalid_registration_code) unless RegistrationCode.valid_for_registration?(params[:reg_code])
		end

		def allow_edit_only_if_not_complete
			redirect_to :root if current_player.registration_complete?
		end

		def after_update_path_for(player)
			interactive_videos_path
		end

end