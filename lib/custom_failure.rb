class CustomFailure < Devise::FailureApp
  def redirect_url
    if warden_options[:scope] == :player
      root_path
    elsif warden_options[:scope] == :operator
      new_operation_operator_session_path
    else
      new_admin_system_admin_session_path
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