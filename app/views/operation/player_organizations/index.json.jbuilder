json.array!(@operation_player_organizations) do |operation_player_organization|
  json.extract! operation_player_organization, :id, :org_type, :name, :address, :contact_name, :contact_position, :contact_email, :contact_phone
  json.url operation_player_organization_url(operation_player_organization, format: :json)
end
