json.array!(@player_groups) do |player_group|
  json.extract! player_group, :id, :operator_id, :reg_code, :program_start_date, :name, :description, :player_organization_id
  json.url player_group_url(player_group, format: :json)
end
