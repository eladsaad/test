class Operation::Operators::SessionsController < Devise::SessionsController
	layout 'operation/layouts/operation'

	# POST /resource/sign_in
	def create
		self.resource = warden.authenticate!(auth_options)
		if (self.resource.disabled?)
			Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
			redirect_to new_operation_operator_session_path, :alert => t(:account_disabled)
		else
			set_flash_message(:notice, :signed_in) if is_flashing_format?
			sign_in(resource_name, resource)
			yield resource if block_given?
			respond_with resource, :location => after_sign_in_path_for(resource)
		end
	end


	def after_sign_out_path_for(operator_symbol)
		operation_root_url
	end
end