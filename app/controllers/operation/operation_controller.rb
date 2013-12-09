class Operation::OperationController < ApplicationController
	layout 'operation/layouts/operation'
	before_filter :authenticate_operation_operator!
end
