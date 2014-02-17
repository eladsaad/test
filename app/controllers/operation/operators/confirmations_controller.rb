class Operation::Operators::ConfirmationsController < Devise::ConfirmationsController
	layout 'operation/layouts/operation'

	def after_confirmation_path_for(resource_name, resource)
    	new_operation_operator_session_path
  	end
end