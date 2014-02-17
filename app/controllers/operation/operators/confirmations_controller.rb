class Operation::Operators::ConfirmationsController < Devise::ConfirmationsController
	layout 'operation/layouts/operation'

	def after_confirmation_path_for(resource_name, resource)
    	admin_root_url
  	end
end