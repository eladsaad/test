json.array!(@operation_players) do |operation_player|
  json.extract! operation_player, :id, :email, :first_name, :last_name, :created_at
  json.url operation_player_url(operation_player, format: :json)
end