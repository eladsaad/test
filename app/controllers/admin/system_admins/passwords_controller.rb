class Admin::SystemAdmins::PasswordsController < Devise::PasswordsController
	layout 'admin/layouts/admin'


  protected
    def after_resetting_password_path_for(resource)
      new_admin_system_admin_session_path
    end

    def after_sending_reset_password_instructions_path_for(resource)
      new_admin_system_admin_session_path
    end

end
