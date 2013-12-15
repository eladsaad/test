class Admin::AdminController < ApplicationController
	layout 'admin/layouts/admin'
	before_filter :authenticate_admin_system_admin!

	def current_ability
		current_admin_system_admin.ability
	end
end
