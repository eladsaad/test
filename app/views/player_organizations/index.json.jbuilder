json.array!(@player_organizations) do |player_organization|
  json.extract! player_organization, :id, :org_type, :name, :address, :contact_name, :contact_position, :contact_email, :contact_phone
  json.url player_organization_url(player_organization, format: :json)
end
