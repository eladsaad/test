class Operation::OperationController < ApplicationController
	layout 'operation/layouts/operation'
	before_filter :authenticate_operation_operator!

	def current_ability
		current_operation_operator.ability
	end
end
