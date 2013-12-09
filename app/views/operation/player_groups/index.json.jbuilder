json.array!(@operation_player_groups) do |operation_player_group|
  json.extract! operation_player_group, :id, :operator_id, :reg_code, :program_start_date, :name, :description, :player_organization_id
  json.url operation_player_group_url(operation_player_group, format: :json)
end