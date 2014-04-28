namespace :db do
  desc "Remove expired API keys from the database"
  task clean_api_keys: :environment do
    keys_to_delete = PlayerApiKey.where('expires_at < ?', Time.now)
    keys_to_delete.destroy_all
  end
end
