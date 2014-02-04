json.array!(@operation_player_groups) do |operation_player_group|
  json.extract! operation_player_group, :id, :operator_id, :reg_code, :screening_date, :name, :description, :player_organization_id, :mobile_station_code, :online_program_id
  json.url operation_player_group_url(operation_player_group, format: :json)
end
