json.extract! @operation_player_group, :id, :operator_id, :reg_code, :program_start_date, :name, :description, :player_organization_id, :mobile_station_code, :created_at, :updated_at
json.extension_params_attributes @operation_player_group.extension_params, :custom_01, :custom_02, :custom_03, :custom_04, :custom_05, :custom_06, :custom_07, :custom_08, :custom_09, :custom_10
