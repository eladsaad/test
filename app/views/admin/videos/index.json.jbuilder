json.array!(@admin_videos) do |admin_video|
  json.extract! admin_video, :id, :url, :thumbnail_url, :name, :language_code_id, :description
  json.url admin_video_url(admin_video, format: :json)
end
