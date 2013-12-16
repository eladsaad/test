class Operation::Operators::SessionsController < Devise::SessionsController
	layout 'operation/layouts/operation'

	def after_sign_out_path_for(operator_symbol)
		operation_root_url
	end
end