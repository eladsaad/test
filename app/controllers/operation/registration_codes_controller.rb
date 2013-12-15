class Operation::RegistrationCodesController < Operation::OperationController

  def fetch
    authorize! :reg_codes, current_operation_operator
    amount = params[:amount].blank? ? 1 : params[:amount]
    @registration_codes = current_operation_operator.fetch_registration_codes(amount)
  end

end


