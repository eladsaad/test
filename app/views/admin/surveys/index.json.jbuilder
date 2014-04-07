json.array!(@admin_surveys) do |admin_survey|
  json.extract! admin_survey, :id, :name, :language_code_id
  json.url admin_survey_url(admin_survey, format: :json)
end
