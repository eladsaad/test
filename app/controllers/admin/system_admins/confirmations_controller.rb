class Admin::SystemAdmins::ConfirmationsController < Devise::ConfirmationsController
	layout 'admin/layouts/admin'

	def after_confirmation_path_for(resource_name, resource)
    	admin_root_url
  	end
end