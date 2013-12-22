class AddSuperAdminToSystemAdmin < ActiveRecord::Migration
  def change
    add_column :system_admins, :super_admin, :boolean
  end
end
