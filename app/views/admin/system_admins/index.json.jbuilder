json.array!(@admin_system_admins) do |admin_system_admin|
  json.extract! admin_system_admin, :id, :email, :first_name, :last_name, :super_admin
  json.url admin_system_admin_url(admin_system_admin, format: :json)
end
