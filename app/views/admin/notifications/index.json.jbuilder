json.array!(@admin_notifications) do |admin_notification|
  json.extract! admin_notification, :id, :name, :language_code, :title, :email_content, :facebook_content
  json.url admin_notification_url(admin_notification, format: :json)
end
