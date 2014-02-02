json.array!(@admin_interactive_videos) do |admin_interactive_video|
  json.extract! admin_interactive_video, :id, :name, :content, :language_code_id, :description
  json.url admin_interactive_video_url(admin_interactive_video, format: :json)
end
