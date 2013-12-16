class Admin::SystemAdmins::SessionsController < Devise::SessionsController
	layout 'admin/layouts/admin'

	def after_sign_out_path_for(system_admin_symbol)
		admin_root_url
	end
end