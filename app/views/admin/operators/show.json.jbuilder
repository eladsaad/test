json.extract! @admin_operator, :id, :name, :email, :country, :reg_code_prefix, :disabled, :created_at, :updated_at
json.online_programs @admin_operator.online_programs, :id, :name
