class Admin::SystemAdmins::ConfirmationsController < Devise::ConfirmationsController
	layout 'admin/layouts/admin'

	def after_confirmation_path_for(resource_name, resource)
    	new_admin_system_admin_session_path
  	end
end