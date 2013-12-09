json.array!(@players) do |player|
  json.extract! player, :id, :username, :email, :first_name, :last_name, :birth_date
  json.url player_url(player, format: :json)
end
