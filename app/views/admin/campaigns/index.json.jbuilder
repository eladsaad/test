json.array!(@admin_campaigns) do |admin_campaign|
  json.extract! admin_campaign, :id, :name, :max_views, :views, :clicks, :trophy_name, :landing_page
  json.url admin_campaign_url(admin_campaign, format: :json)
end
