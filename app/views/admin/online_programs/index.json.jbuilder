json.array!(@admin_online_programs) do |admin_online_program|
  json.extract! admin_online_program, :id, :name, :codename, :language_code_id, :description, :background_image_id, :promo_video_id
  json.url admin_online_program_url(admin_online_program, format: :json)
end
