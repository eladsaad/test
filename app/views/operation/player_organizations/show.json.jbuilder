json.extract! @operation_player_organization, :id, :operator_id, :org_type, :name, :address, :contact_name, :contact_position, :contact_email, :contact_phone, :created_at, :updated_at
json.extension_params_attributes @operation_player_organization.extension_params, :custom_01, :custom_02, :custom_03, :custom_04, :custom_05, :custom_06, :custom_07, :custom_08, :custom_09, :custom_10
