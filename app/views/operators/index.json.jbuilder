json.array!(@operators) do |operator|
  json.extract! operator, :id, :name, :email, :country, :reg_code_prefix
  json.url operator_url(operator, format: :json)
end
