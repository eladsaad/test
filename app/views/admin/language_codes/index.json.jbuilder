json.array!(@admin_language_codes) do |admin_language_code|
  json.extract! admin_language_code, :id, :name, :code
  json.url admin_language_code_url(admin_language_code, format: :json)
end
