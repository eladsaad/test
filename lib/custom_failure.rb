class CustomFailure < Devise::FailureApp
  
  def redirect_url
    if warden_options[:scope] == :admin_system_admin
      new_admin_system_admin_session_path
    elsif warden_options[:scope] == :operation_operator
      new_operation_operator_session_path
    else
      root_url
    end
  end

  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end

end