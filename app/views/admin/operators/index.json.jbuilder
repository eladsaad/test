json.array!(@admin_operators) do |admin_operator|
  json.extract! admin_operator, :id, :name, :email, :country, :reg_code_prefix
  json.url admin_operator_url(admin_operator, format: :json)
end
