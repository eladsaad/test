json.array!(@system_admins) do |system_admin|
  json.extract! system_admin, :id, :email, :first_name, :last_name
  json.url system_admin_url(system_admin, format: :json)
end
